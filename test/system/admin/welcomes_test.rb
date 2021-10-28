# frozen_string_literal: true

require 'application_system_test_case'

class Admin::WelcomesTest < ApplicationSystemTestCase
  setup do
    @admin_welcome = admin_welcomes(:one)
  end

  test 'visiting the index' do
    visit admin_welcomes_url
    assert_selector 'h1', text: 'Admin/Welcomes'
  end

  test 'creating a Welcome' do
    visit admin_welcomes_url
    click_on 'New Admin/Welcome'

    fill_in 'Index', with: @admin_welcome.index
    click_on 'Create Welcome'

    assert_text 'Welcome was successfully created'
    click_on 'Back'
  end

  test 'updating a Welcome' do
    visit admin_welcomes_url
    click_on 'Edit', match: :first

    fill_in 'Index', with: @admin_welcome.index
    click_on 'Update Welcome'

    assert_text 'Welcome was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Welcome' do
    visit admin_welcomes_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Welcome was successfully destroyed'
  end
end
