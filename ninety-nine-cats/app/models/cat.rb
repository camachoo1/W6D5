# == Schema Information
#
# Table name: cats
#
#  id          :bigint           not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'action_view'

class Cat < ApplicationRecord
  include ActionView::Helpers::DateHelper

  CAT_COLORS = %w[grey black white orange]

  validates :birth_date, presence: true
  validates :sex,
            inclusion: {
              in: %w[F M],
              message: '%{value} is not a valid sex',
            }
  validates :color,
            inclusion: {
              in: CAT_COLORS,
              message: '%{value} is not a valid color',
            }
  validate :birth_date_cannot_be_future

  def age
    time_ago_in_words(birth_date)
  end

  def birth_date_cannot_be_future
    if birth_date.nil? || birth_date > Date.today
      errors.add(:birth_date, 'birth date cannot be in the future')
    end
  end
end
