# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class Ability
  include CanCan::Ability

  ALL_MODELS = [Accomplishment, Advisement, AdvisementAuthorization, Allocation,
                City, ClassEnrollment, Country, Course, CourseClass, CourseType,
                CustomVariable, Deferral, DeferralType, Dismissal, 
                DismissalReason, Enrollment, EnrollmentStatus, Institution,
                Level, Major, Notification, NotificationLog, Phase, 
                PhaseCompletion, PhaseDuration, Professor, ProfessorResearchArea,
                ResearchArea, Role, Scholarship, ScholarshipDuration, 
                ScholarshipType, Sponsor, State, Student, StudentMajor, 
                ThesisDefenseCommitteeParticipation, User, Version, YearSemester] 


  def initialize(user)
    alias_action :list, :row, :show_search, :render_field, :class_schedule_pdf,
        :to_pdf, :summary_pdf, :academic_transcript_pdf, :grades_report_pdf, 
        :browse, :simulate, :set_query_date, :cities, :states, :to => :read
    alias_action :update_column, :edit_associated, :new_existing, :add_existing, 
        :execute_now, :execute_now, :notify, :to => :update
    alias_action :delete, :destroy_existing, :to => :destroy
    #as_action_aliases

    user ||= User.new

    role_id = user.role_id


    if role_id == Role::ROLE_ADMINISTRADOR
      can :manage, :all
      cannot [:destroy, :update], Role
    elsif role_id == Role::ROLE_COORDENACAO
      can :manage, (Ability::ALL_MODELS - [Role, Notification, CustomVariable])
    elsif role_id == Role::ROLE_PROFESSOR
      can :read, (Ability::ALL_MODELS - [User, Role, CustomVariable, Version, Notification, NotificationLog])
    elsif role_id == Role::ROLE_SECRETARIA
      can :manage, (Ability::ALL_MODELS - [User, Role, CustomVariable, Version, Notification])
    end
    can :notify, Notification

    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user 
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on. 
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/ryanb/cancan/wiki/Defining-Abilities
  end
end
