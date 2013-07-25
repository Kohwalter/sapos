
# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

# encoding: UTF-8

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130527235843) do

  create_table "enrollment_statuses", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "levels", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "countries", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "states", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.integer  "country_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["country_id"], :name => "fk__states_country_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_states_country_id"
  end

  create_table "cities", :force => true do |t|
    t.string   "name"
    t.integer  "state_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.index ["state_id"], :name => "fk__cities_state_id"
    t.foreign_key ["state_id"], "states", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_cities_state_id"
  end

  create_table "students", :force => true do |t|
    t.string   "name"
    t.string   "cpf"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.text     "obs"
    t.date     "birthdate"
    t.string   "sex"
    t.string   "civil_status"
    t.string   "father_name"
    t.string   "mother_name"
    t.integer  "country_id"
    t.integer  "birthplace"
    t.string   "identity_number"
    t.string   "identity_issuing_body"
    t.date     "identity_expedition_date"
    t.string   "employer"
    t.string   "job_position"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "neighbourhood"
    t.string   "zip_code"
    t.string   "address"
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "email"
    t.index ["country_id"], :name => "fk__students_country_id"
    t.index ["birthplace"], :name => "fk__students_birthplace"
    t.index ["state_id"], :name => "fk__students_state_id"
    t.index ["city_id"], :name => "fk__students_city_id"
    t.foreign_key ["birthplace"], "states", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_students_birthplace"
    t.foreign_key ["city_id"], "cities", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_students_city_id"
    t.foreign_key ["country_id"], "countries", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_students_country_id"
    t.foreign_key ["state_id"], "states", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_students_state_id"
  end

  create_table "enrollments", :force => true do |t|
    t.string   "enrollment_number"
    t.integer  "student_id"
    t.integer  "level_id"
    t.integer  "enrollment_status_id"
    t.date     "admission_date"
    t.text     "obs"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.index ["student_id"], :name => "fk__enrollments_student_id"
    t.index ["level_id"], :name => "fk__enrollments_level_id"
    t.index ["enrollment_status_id"], :name => "fk__enrollments_enrollment_status_id"
    t.foreign_key ["enrollment_status_id"], "enrollment_statuses", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_enrollments_enrollment_status_id"
    t.foreign_key ["level_id"], "levels", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_enrollments_level_id"
    t.foreign_key ["student_id"], "students", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_enrollments_student_id"
  end

  create_table "phases", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "accomplishments", :force => true do |t|
    t.integer  "enrollment_id"
    t.integer  "phase_id"
    t.date     "conclusion_date"
    t.string   "obs"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.index ["enrollment_id"], :name => "fk__accomplishments_enrollment_id"
    t.index ["phase_id"], :name => "fk__accomplishments_phase_id"
    t.foreign_key ["enrollment_id"], "enrollments", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_accomplishments_enrollment_id"
    t.foreign_key ["phase_id"], "phases", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_accomplishments_phase_id"
  end

  create_table "professors", :force => true do |t|
    t.string   "name"
    t.string   "cpf"
    t.date     "birthdate"
    t.datetime "created_at",               :null => false
    t.datetime "updated_at",               :null => false
    t.string   "sex"
    t.string   "civil_status"
    t.string   "identity_number"
    t.string   "identity_issuing_body"
    t.string   "identity_expedition_date"
    t.string   "neighbourhood"
    t.string   "address"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "zip_code"
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "siape"
    t.string   "enrollment_number"
    t.index ["state_id"], :name => "fk__professors_state_id"
    t.index ["city_id"], :name => "fk__professors_city_id"
    t.foreign_key ["city_id"], "cities", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_professors_city_id"
    t.foreign_key ["state_id"], "states", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_professors_state_id"
  end

  create_table "advisement_authorizations", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "level_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.index ["professor_id"], :name => "fk__advisement_authorizations_professor_id"
    t.index ["level_id"], :name => "fk__advisement_authorizations_level_id"
    t.foreign_key ["level_id"], "levels", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_advisement_authorizations_level_id"
    t.foreign_key ["professor_id"], "professors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_advisement_authorizations_professor_id"
  end

  create_table "advisements", :force => true do |t|
    t.integer  "professor_id",  :null => false
    t.integer  "enrollment_id", :null => false
    t.boolean  "main_advisor"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.index ["professor_id"], :name => "fk__advisements_professor_id"
    t.index ["enrollment_id"], :name => "fk__advisements_enrollment_id"
    t.index ["professor_id"], :name => "index_advisements_on_professor_id"
    t.index ["enrollment_id"], :name => "index_advisements_on_enrollment_id"
    t.foreign_key ["enrollment_id"], "enrollments", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_advisements_enrollment_id"
    t.foreign_key ["professor_id"], "professors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_advisements_professor_id"
  end

  create_table "course_types", :force => true do |t|
    t.string   "name"
    t.boolean  "has_score"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "research_areas", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.text     "content"
    t.integer  "credits"
    t.integer  "research_area_id"
    t.integer  "course_type_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.index ["research_area_id"], :name => "fk__courses_research_area_id"
    t.index ["course_type_id"], :name => "fk__courses_course_type_id"
    t.foreign_key ["course_type_id"], "course_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_courses_course_type_id"
    t.foreign_key ["research_area_id"], "research_areas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_courses_research_area_id"
  end

  create_table "course_classes", :force => true do |t|
    t.string   "name"
    t.integer  "course_id"
    t.integer  "professor_id"
    t.integer  "year"
    t.integer  "semester"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.index ["course_id"], :name => "fk__course_classes_course_id"
    t.index ["professor_id"], :name => "fk__course_classes_professor_id"
    t.foreign_key ["course_id"], "courses", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_course_classes_course_id"
    t.foreign_key ["professor_id"], "professors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_course_classes_professor_id"
  end

  create_table "allocations", :force => true do |t|
    t.string   "day"
    t.string   "room"
    t.integer  "start_time"
    t.integer  "end_time"
    t.integer  "course_class_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.index ["course_class_id"], :name => "fk__allocations_course_class_id"
    t.foreign_key ["course_class_id"], "course_classes", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_allocations_course_class_id"
  end

  create_table "class_enrollments", :force => true do |t|
    t.text     "obs"
    t.integer  "grade"
    t.string   "situation"
    t.integer  "course_class_id"
    t.integer  "enrollment_id"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.boolean  "disapproved_by_absence", :default => false
    t.index ["course_class_id"], :name => "fk__class_enrollments_course_class_id"
    t.index ["enrollment_id"], :name => "fk__class_enrollments_enrollment_id"
    t.foreign_key ["course_class_id"], "course_classes", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_class_enrollments_course_class_id"
    t.foreign_key ["enrollment_id"], "enrollments", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_class_enrollments_enrollment_id"
  end

  create_table "deferral_types", :force => true do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "duration_semesters"
    t.integer  "phase_id"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "duration_months",    :default => 0
    t.integer  "duration_days",      :default => 0
    t.index ["phase_id"], :name => "fk__deferral_types_phase_id"
    t.foreign_key ["phase_id"], "phases", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_deferral_types_phase_id"
  end

  create_table "deferrals", :force => true do |t|
    t.date     "approval_date"
    t.string   "obs"
    t.integer  "enrollment_id"
    t.integer  "deferral_type_id"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.index ["enrollment_id"], :name => "fk__deferrals_enrollment_id"
    t.index ["deferral_type_id"], :name => "fk__deferrals_deferral_type_id"
    t.foreign_key ["deferral_type_id"], "deferral_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_deferrals_deferral_type_id"
    t.foreign_key ["enrollment_id"], "enrollments", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_deferrals_enrollment_id"
  end

  create_table "dismissal_reasons", :force => true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "dismissals", :force => true do |t|
    t.date     "date"
    t.integer  "enrollment_id"
    t.integer  "dismissal_reason_id"
    t.text     "obs"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.index ["enrollment_id"], :name => "fk__dismissals_enrollment_id"
    t.index ["dismissal_reason_id"], :name => "fk__dismissals_dismissal_reason_id"
    t.foreign_key ["dismissal_reason_id"], "dismissal_reasons", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_dismissals_dismissal_reason_id"
    t.foreign_key ["enrollment_id"], "enrollments", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_dismissals_enrollment_id"
  end

  create_table "institutions", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "code"
  end

  create_table "majors", :force => true do |t|
    t.string   "name"
    t.integer  "level_id"
    t.integer  "institution_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.index ["institution_id"], :name => "fk__majors_institution_id"
    t.index ["level_id"], :name => "fk__majors_level_id"
    t.foreign_key ["institution_id"], "institutions", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_majors_institution_id"
    t.foreign_key ["level_id"], "levels", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_majors_level_id"
  end

  create_table "majors_students", :id => false, :force => true do |t|
    t.integer "course_id",  :null => false
    t.integer "student_id", :null => false
    t.index ["course_id"], :name => "index_majors_students_on_course_id"
    t.index ["student_id"], :name => "index_majors_students_on_student_id"
    t.index ["course_id"], :name => "fk__majors_students_course_id"
    t.index ["student_id"], :name => "fk__majors_students_student_id"
    t.foreign_key ["course_id"], "majors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_majors_students_course_id"
    t.foreign_key ["student_id"], "students", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_majors_students_student_id"
  end

  create_table "phase_durations", :force => true do |t|
    t.integer  "phase_id"
    t.integer  "level_id"
    t.integer  "deadline_semesters"
    t.datetime "created_at",                        :null => false
    t.datetime "updated_at",                        :null => false
    t.integer  "deadline_months",    :default => 0
    t.integer  "deadline_days",      :default => 0
    t.index ["phase_id"], :name => "fk__phase_durations_phase_id"
    t.index ["level_id"], :name => "fk__phase_durations_level_id"
    t.foreign_key ["level_id"], "levels", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_phase_durations_level_id"
    t.foreign_key ["phase_id"], "phases", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_phase_durations_phase_id"
  end

  create_table "professor_research_areas", :force => true do |t|
    t.integer  "professor_id"
    t.integer  "research_area_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "professor_research_areas", ["professor_id"], :name => "professor_research_areas_professor_id_fkey"
  add_index "professor_research_areas", ["research_area_id"], :name => "professor_research_areas_research_area_id_fkey"

  create_table "professors", :force => true do |t|
    t.string   "name"
    t.string   "cpf"
    t.date     "birthdate"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "sex"
    t.string   "civil_status"
    t.string   "identity_number"
    t.string   "identity_issuing_body"
    t.string   "identity_expedition_date"
    t.string   "neighbourhood"
    t.string   "address"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "zip_code"
    t.string   "telephone1"
    t.string   "telephone2"
    t.string   "siape"
    t.string   "enrollment_number"
  end

  add_index "professors", ["city_id"], :name => "professors_city_id_fkey"
  add_index "professors", ["state_id"], :name => "professors_state_id_fkey"

  create_table "research_areas", :force => true do |t|
    t.string   "name"
    t.string   "code"
    t.datetime "created_at",       :null => false
    t.datetime "updated_at",       :null => false
    t.index ["professor_id"], :name => "fk__professor_research_areas_professor_id"
    t.index ["research_area_id"], :name => "fk__professor_research_areas_research_area_id"
    t.foreign_key ["professor_id"], "professors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_professor_research_areas_professor_id"
    t.foreign_key ["research_area_id"], "research_areas", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_professor_research_areas_research_area_id"
  end

  create_table "roles", :force => true do |t|
    t.string   "name",        :limit => 50, :null => false
    t.string   "description",               :null => false
    t.datetime "created_at",                :null => false
    t.datetime "updated_at",                :null => false
  end

  create_table "scholarship_types", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "sponsors", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "scholarships", :force => true do |t|
    t.string   "scholarship_number"
    t.integer  "level_id"
    t.integer  "sponsor_id"
    t.integer  "scholarship_type_id"
    t.date     "start_date"
    t.date     "end_date"
    t.text     "obs"
    t.datetime "created_at",          :null => false
    t.datetime "updated_at",          :null => false
    t.integer  "professor_id"
    t.index ["level_id"], :name => "fk__scholarships_level_id"
    t.index ["sponsor_id"], :name => "fk__scholarships_sponsor_id"
    t.index ["scholarship_type_id"], :name => "fk__scholarships_scholarship_type_id"
    t.index ["professor_id"], :name => "fk__scholarships_professor_id"
    t.foreign_key ["level_id"], "levels", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_scholarships_level_id"
    t.foreign_key ["professor_id"], "professors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_scholarships_professor_id"
    t.foreign_key ["scholarship_type_id"], "scholarship_types", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_scholarships_scholarship_type_id"
    t.foreign_key ["sponsor_id"], "sponsors", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_scholarships_sponsor_id"
  end

  create_table "scholarship_durations", :force => true do |t|
    t.integer  "scholarship_id", :null => false
    t.integer  "enrollment_id",  :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.text     "obs"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
    t.date     "cancel_date"
    t.index ["scholarship_id"], :name => "fk__scholarship_durations_scholarship_id"
    t.index ["enrollment_id"], :name => "fk__scholarship_durations_enrollment_id"
    t.index ["scholarship_id"], :name => "index_scholarship_durations_on_scholarship_id"
    t.index ["enrollment_id"], :name => "index_scholarship_durations_on_enrollment_id"
    t.foreign_key ["enrollment_id"], "enrollments", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_scholarship_durations_enrollment_id"
    t.foreign_key ["scholarship_id"], "scholarships", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_scholarship_durations_scholarship_id"
  end


  add_index "students", ["birthplace"], :name => "students_birthplace_fkey"
  add_index "students", ["city_id"], :name => "students_city_id_fkey"
  add_index "students", ["country_id"], :name => "students_country_id_fkey"
  add_index "students", ["state_id"], :name => "students_state_id_fkey"


  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"

    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.integer  "failed_attempts",        :default => 0
    t.string   "unlock_token"
    t.datetime "locked_at"
    t.integer  "role_id",                :default => 1,  :null => false
    t.index ["role_id"], :name => "fk__users_role_id"
    t.foreign_key ["role_id"], "roles", ["id"], :on_update => :restrict, :on_delete => :restrict, :name => "fk_users_role_id"
  end


  add_index "users", ["role_id"], :name => "users_role_id_fkey"

  add_foreign_key "accomplishments", ["enrollment_id"], "enrollments", ["id"], :name => "accomplishments_enrollment_id_fkey"
  add_foreign_key "accomplishments", ["phase_id"], "phases", ["id"], :name => "accomplishments_phase_id_fkey"

  add_foreign_key "advisement_authorizations", ["level_id"], "levels", ["id"], :name => "advisement_authorizations_level_id_fkey"
  add_foreign_key "advisement_authorizations", ["professor_id"], "professors", ["id"], :name => "advisement_authorizations_professor_id_fkey"

  add_foreign_key "advisements", ["enrollment_id"], "enrollments", ["id"], :name => "advisements_enrollment_id_fkey"
  add_foreign_key "advisements", ["professor_id"], "professors", ["id"], :name => "advisements_professor_id_fkey"

  add_foreign_key "allocations", ["course_class_id"], "course_classes", ["id"], :name => "allocations_course_class_id_fkey"

  add_foreign_key "cities", ["state_id"], "states", ["id"], :name => "cities_state_id_fkey"

  add_foreign_key "class_enrollments", ["course_class_id"], "course_classes", ["id"], :name => "class_enrollments_course_class_id_fkey"
  add_foreign_key "class_enrollments", ["enrollment_id"], "enrollments", ["id"], :name => "class_enrollments_enrollment_id_fkey"

  add_foreign_key "course_classes", ["course_id"], "courses", ["id"], :name => "course_classes_course_id_fkey"
  add_foreign_key "course_classes", ["professor_id"], "professors", ["id"], :name => "course_classes_professor_id_fkey"

  add_foreign_key "courses", ["course_type_id"], "course_types", ["id"], :name => "courses_course_type_id_fkey"
  add_foreign_key "courses", ["research_area_id"], "research_areas", ["id"], :name => "courses_research_area_id_fkey"

  add_foreign_key "deferral_types", ["phase_id"], "phases", ["id"], :name => "deferral_types_phase_id_fkey"

  add_foreign_key "deferrals", ["deferral_type_id"], "deferral_types", ["id"], :name => "deferrals_deferral_type_id_fkey"
  add_foreign_key "deferrals", ["enrollment_id"], "enrollments", ["id"], :name => "deferrals_enrollment_id_fkey"

  add_foreign_key "dismissals", ["dismissal_reason_id"], "dismissal_reasons", ["id"], :name => "dismissals_dismissal_reason_id_fkey"
  add_foreign_key "dismissals", ["enrollment_id"], "enrollments", ["id"], :name => "dismissals_enrollment_id_fkey"

  add_foreign_key "enrollments", ["enrollment_status_id"], "enrollment_statuses", ["id"], :name => "enrollments_enrollment_status_id_fkey"
  add_foreign_key "enrollments", ["level_id"], "levels", ["id"], :name => "enrollments_level_id_fkey"
  add_foreign_key "enrollments", ["student_id"], "students", ["id"], :name => "enrollments_student_id_fkey"

  add_foreign_key "majors", ["institution_id"], "institutions", ["id"], :name => "courses_institution_id_fkey"
  add_foreign_key "majors", ["level_id"], "levels", ["id"], :name => "courses_level_id_fkey"

  add_foreign_key "majors_students", ["major_id"], "majors", ["id"], :name => "courses_students_major_id_fkey"
  add_foreign_key "majors_students", ["student_id"], "students", ["id"], :name => "courses_students_student_id_fkey"

  add_foreign_key "phase_durations", ["level_id"], "levels", ["id"], :name => "phase_durations_level_id_fkey"
  add_foreign_key "phase_durations", ["phase_id"], "phases", ["id"], :name => "phase_durations_phase_id_fkey"

  add_foreign_key "professor_research_areas", ["professor_id"], "professors", ["id"], :name => "professor_research_areas_professor_id_fkey"
  add_foreign_key "professor_research_areas", ["research_area_id"], "research_areas", ["id"], :name => "professor_research_areas_research_area_id_fkey"

  add_foreign_key "professors", ["city_id"], "cities", ["id"], :name => "professors_city_id_fkey"
  add_foreign_key "professors", ["state_id"], "states", ["id"], :name => "professors_state_id_fkey"

  add_foreign_key "scholarship_durations", ["enrollment_id"], "enrollments", ["id"], :name => "scholarship_durations_enrollment_id_fkey"
  add_foreign_key "scholarship_durations", ["scholarship_id"], "scholarships", ["id"], :name => "scholarship_durations_scholarship_id_fkey"

  add_foreign_key "scholarships", ["level_id"], "levels", ["id"], :name => "scholarships_level_id_fkey"
  add_foreign_key "scholarships", ["professor_id"], "professors", ["id"], :name => "scholarships_professor_id_fkey"
  add_foreign_key "scholarships", ["scholarship_type_id"], "scholarship_types", ["id"], :name => "scholarships_scholarship_type_id_fkey"
  add_foreign_key "scholarships", ["sponsor_id"], "sponsors", ["id"], :name => "scholarships_sponsor_id_fkey"

  add_foreign_key "states", ["country_id"], "countries", ["id"], :name => "states_country_id_fkey"

  add_foreign_key "students", ["birthplace"], "states", ["id"], :name => "students_birthplace_fkey"
  add_foreign_key "students", ["city_id"], "cities", ["id"], :name => "students_city_id_fkey"
  add_foreign_key "students", ["country_id"], "countries", ["id"], :name => "students_country_id_fkey"
  add_foreign_key "students", ["state_id"], "states", ["id"], :name => "students_state_id_fkey"

  add_foreign_key "users", ["role_id"], "roles", ["id"], :name => "users_role_id_fkey"

end
