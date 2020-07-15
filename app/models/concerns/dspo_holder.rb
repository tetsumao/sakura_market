module DspoHolder
  def self.included(base)
    base.extend(ClassMethods)
    base.class_eval do
      scope :default_order, -> {order(:dspo)}
    end
  end

  extend ActiveSupport::Concern

  module ClassMethods
    def next_dspo
      max_dspo = maximum(:dspo)
      max_dspo.present? ? (max_dspo + 1) : 1
    end
  end
end
