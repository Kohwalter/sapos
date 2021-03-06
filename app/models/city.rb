# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class City < ActiveRecord::Base
  attr_accessible :name, :state
  belongs_to :state
  has_many :students, :dependent => :restrict
  has_many :student_birth_cities, :class_name => 'Student', :foreign_key => 'birth_city_id', :dependent => :restrict
  has_many :professors, :dependent => :restrict
  
  has_paper_trail

  validates :state, :presence => true

  validates :name, :presence => true

  def to_label
  	"#{self.name}"
  end
end
