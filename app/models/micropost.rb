# == Schema Information
# Schema version: 20101107113210
#
# Table name: microposts
#
#  id         :integer(4)      not null, primary key
#  content    :text
#  user_id    :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class Micropost < ActiveRecord::Base
  attr_accessible :content
  belongs_to :user

  validates :user_id, :presence => true
  validates :content, :presence => true, :length => { :within => 1..140 }

  default_scope :order => "created_at DESC"

  def self.per_page               # class method, used by will_paginate
    10
  end
end

