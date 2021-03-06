# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class ResearchArea < ActiveRecord::Base
  has_many :courses, :dependent => :restrict
  has_many :enrollments, :dependent => :restrict
  has_many :professors, :through => :professor_research_areas
  has_many :professor_research_areas, :dependent => :destroy

  has_paper_trail

  validates :name, :presence => true, :uniqueness => true
  validates :code, :presence => true, :uniqueness => true

  attr_accessible :name, :code

  def to_label
    "#{code} - #{name}"
  end
end
