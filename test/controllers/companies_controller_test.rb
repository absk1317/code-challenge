require "test_helper"
require "application_system_test_case"

class CompaniesControllerTest < ApplicationSystemTestCase
  def setup
    @company = companies(:hometown_painting)
  end

  test "Index" do
    visit companies_path

    assert_text "Companies"
    assert_text "Hometown Painting"
    assert_text "Wolf Painting"
  end

  test "Show" do
    visit company_path(@company)

    assert_text @company.name
    assert_text @company.phone
    assert_text @company.email
    assert_text @company.location
  end

  test "Update Success" do
    visit edit_company_path(@company)

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company", fill_options: { clear: :backspace })
      fill_in("company_zip_code", with: "93009")
      fill_in("company_email", with: "new_test_company@getmainstreet.com", fill_options: { clear: :backspace })
      fill_in("company_brand_color", with: "#ffffff")
      click_button "Update Company"
    end

    assert_text "Changes Saved"

    @company.reload
    assert_equal "Updated Test Company", @company.name
    assert_equal "93009", @company.zip_code
    assert_equal "#ffffff", @company.brand_color
  end

  test "Update Failure" do
    visit edit_company_path(@company)
    name = @company.name

    within("form#edit_company_#{@company.id}") do
      fill_in("company_name", with: "Updated Test Company")
      fill_in("company_zip_code", with: "93009")
      click_button "Update Company"
    end

    assert_text 'Email must be a mainstreet.com account'

    @company.reload
    assert_equal name, @company.name
  end

  test 'Delete' do
    visit edit_company_path(@company)

    page.accept_confirm do
      click_link 'Delete'
    end

    assert_text 'Deleted'

    assert_raises ActiveRecord::RecordNotFound do
      @company.reload
    end
  end

  test "Create" do
    visit new_company_path

    within("form#new_company") do
      fill_in("company_name", with: "New Test Company")
      fill_in("company_zip_code", with: "28173")
      fill_in("company_phone", with: "5553335555")
      fill_in("company_email", with: "new_test_company@getmainstreet.com")
      click_button "Create Company"
    end

    assert_text "Saved"

    last_company = Company.last
    assert_equal "New Test Company", last_company.name
    assert_equal "28173", last_company.zip_code
  end
end
