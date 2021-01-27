class Company < ApplicationRecord
  MAIL_REGEX = /\A[a-zA-Z_0-9.]+@getmainstreet.com/.freeze

  has_rich_text :description

  validates :email, format: { with: MAIL_REGEX, message: 'must be a mainstreet.com account' }, allow_blank: true
end
