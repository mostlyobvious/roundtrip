require 'active_support/slices'
require 'transitions'
require 'active_record/transitions'
require "roundtrip/engine"

module Roundtrip
end

class UpdatableValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    record.errors[attribute] << 'must be updatable' unless value.try(:updatable?) || !record.new_record?
  end
end
