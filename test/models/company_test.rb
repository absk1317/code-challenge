require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test '#email validation with getmainstreet email' do
    company = Company.new(email: "foo@bar.biz")
    assert_equal company.valid?, false
    assert company.errors.messages[:email].include?('must be a mainstreet.com account')
  end

  test '#email validation blank email' do
    company = Company.new(name: 'Foo Bar', email: nil)
    assert company.save
    assert_equal 'Foo Bar', company.name
  end

  test '# email validation valid email' do
    company = Company.new(name: 'Foo Bar', email: 'foo@getmainstreet.com')
    assert company.save
    assert_equal 'Foo Bar', company.name
    assert_equal 'foo@getmainstreet.com', company.email
  end

  test '#zipcode fetch success, on company creation' do
    company = Company.new(name: 'Foo Bar', zip_code: 45039)
    assert company.save
    assert_equal company.city, 'Maineville'
    assert_equal company.state, 'Ohio'
  end

  test '#zipcode fetch success, on company updation' do
    company = Company.new(name: 'Foo Bar', zip_code: 45039)
    company.update zip_code: '93001'
    assert_equal company.city, 'Ventura'
    assert_equal company.state, 'California'
  end

  test '#location' do
    company = Company.new(name: 'Foo Bar', city: 'Foo', state: 'Bar')
    assert_equal company.location, "#{company.city}, #{company.state}"

    company = Company.new(name: 'Foo Bar', city: '', state: 'Bar')
    assert_equal company.location, company.state

    company = Company.new(name: 'Foo Bar', city: 'Foo')
    assert_equal company.location, company.city

    company = Company.new(name: 'Foo Bar')
    assert_equal company.location, '-'
  end
end
