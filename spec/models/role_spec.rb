# -*- coding: utf-8 -*-
# == Schema Information
# Schema version: 20140213161624
#
# Table name: roles
#
#  created_at :datetime
#  id         :integer          not null, primary key
#  name       :string(255)
#  updated_at :datetime
#

require 'spec_helper'

describe Role do

  it 'can be instantiated' do
    FactoryGirl.build(:role).should be_an_instance_of(Role)
  end

  it 'can be saved successfully' do
    FactoryGirl.create(:role).should be_persisted
  end
end
