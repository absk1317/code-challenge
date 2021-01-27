class Company < ApplicationRecord
  MAIL_REGEX = /\A[a-zA-Z_0-9.]+@getmainstreet.com/.freeze

  has_rich_text :description

  validates :email, format: { with: MAIL_REGEX, message: 'must be a mainstreet.com account' }, allow_blank: true

  before_save :populate_city_state, if: -> { zip_code_changed? }

  ## decorator for company location.
  ## should ideally be in a decorator class
  def location
    if city.present? && state.present?
      "#{city}, #{state}"
    elsif city.present?
      city
    elsif state.present?
      state
    else
      '-'
    end
  end

  private

  ## try to fetch data from the zipcodes gem (Provided with repo), fail gracefully if any exception occurs
  def populate_city_state
    ## This could be moved to a PORO service object, for more maintainability.
    data = ZipCodes.identify(zip_code)
    self.state = data[:state_name]
    self.city = data[:city]
  rescue StandardError => err
    puts Rails.logger.info "## error occured while fetching city and state. backtrace: #{err}"
  end
end
