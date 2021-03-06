# encoding: utf-8
# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class AdvisementsController < ApplicationController
  authorize_resource

  active_scaffold :advisement do |config|

    config.action_links.add 'to_pdf', :label => I18n.t('active_scaffold.to_pdf'), :page => true, :type => :collection, :parameters => {:format => 'pdf'}

    #Enables advanced search A.K.A FieldSearch
    config.actions.swap :search, :field_search

    #Adiciona coluna virtual para orientações ativas    
    config.columns.add :active, :co_advisor, :enrollment_number, :student_name, :level

    config.field_search.columns = [:professor, :enrollment_number, :level, :student_name, :main_advisor, :active, :co_advisor]


    config.columns[:student_name].includes = [{:enrollment => :student}]
    config.columns[:active].search_sql = ""
    config.columns[:active].search_ui = :select
    config.columns[:co_advisor].search_sql = ""
    config.columns[:co_advisor].search_ui = :select
    config.columns[:enrollment_number].search_sql = "enrollments.enrollment_number"
    config.columns[:student_name].search_sql = "students.name"
    config.columns[:level].search_sql = "enrollments.level_id"
    config.columns[:level].search_ui = :select

    config.list.columns = [:professor, :enrollment, :main_advisor, :active, :co_advisor]
    config.columns[:professor].sort_by :sql => "professors.name"
    config.columns[:enrollment_number].sort_by :sql => "enrollments.enrollment_number"
    config.columns[:active].sort_by :method => "active_order"
    config.columns[:co_advisor].sort_by :method => "co_advisor_order"
    config.columns[:student_name].sort_by :sql => "students.name"
    config.list.sorting = {:enrollment => 'ASC'}
    config.create.label = :create_advisement_label
    config.columns[:professor].form_ui = :record_select
    config.columns[:enrollment].form_ui = :record_select
    config.create.columns = [:professor, :enrollment, :main_advisor]
    config.update.columns = [:professor, :enrollment, :main_advisor]
    config.show.columns = [:professor, :enrollment, :main_advisor, :co_advisor_list]
  end

  def self.condition_for_active_column(column, value, like_pattern)
    sql_actives = "enrollments.id IN(
      SELECT enrollments.id
      FROM enrollments
      LEFT OUTER JOIN dismissals
      ON dismissals.enrollment_id = enrollments.id
      WHERE dismissals.id IS NULL
    )"
    sql_not_actives = "enrollments.id IN(
      SELECT enrollments.id
      FROM enrollments
      LEFT OUTER JOIN dismissals
      ON dismissals.enrollment_id = enrollments.id
      WHERE dismissals.id IS NOT NULL
    )"
    sql_all = "enrollments.id IN(
      SELECT enrollments.id
      FROM enrollments
      LEFT OUTER JOIN dismissals
      ON dismissals.enrollment_id = enrollments.id   
    )"

    case value
      when "active" then
        sql_to_use = sql_actives
      when "not_active" then
        sql_to_use = sql_not_actives
      when "all" then
        sql_to_use = sql_all
      else
        sql_to_use = sql_all
    end

    [sql_to_use]
  end

  def self.condition_for_co_advisor_column(column, value, like_pattern)
    sql_sim = "enrollments.id IN(
                SELECT enrollments.id
                FROM enrollments
                LEFT OUTER JOIN advisements
                ON enrollments.id = advisements.enrollment_id
                WHERE advisements.main_advisor = FALSE
              )"
    sql_nao = "enrollments.id NOT IN(
                SELECT enrollments.id
                FROM enrollments
                LEFT OUTER JOIN advisements
                ON enrollments.id = advisements.enrollment_id
                WHERE advisements.main_advisor = FALSE
              )"
    sql_all = "professors.id IN(
                SELECT professors.id
                FROM professors
                LEFT OUTER JOIN advisements
                ON professors.id = advisements.professor_id
              )"

    case value
      when "all" then
        sql_to_use = sql_all
      when "nao" then
        sql_to_use = sql_nao
      when "sim" then
        sql_to_use = sql_sim
      else
        sql_to_use = sql_all
    end

    [sql_to_use]
  end

  def to_pdf
    each_record_in_page {}
    
    @advisements = find_page(:sorting => active_scaffold_config.list.user.sorting).items.map do |adv|
      [
          adv.professor[:name],
          adv.enrollment[:enrollment_number],
          adv.enrollment.student[:name],
          adv.enrollment.level[:name]
      ]
    end

    respond_to do |format|
      format.pdf do
        send_data render_to_string, :filename => "#{I18n.t("pdf_content.advisements.to_pdf.filename")}.pdf", :type => "application/pdf"
      end
    end
  end
end
