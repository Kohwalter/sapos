# Copyright (c) 2013 Universidade Federal Fluminense (UFF).
# This file is part of SAPOS. Please, consult the license terms in the LICENSE file.

class EnrollmentStatus < ActiveRecord::Base
   validates :name, :presence => true, :uniqueness => true
   has_many :enrollments, :dependent => :restrict
   has_paper_trail

   def to_label
  	"#{self.name}"
  end
end
