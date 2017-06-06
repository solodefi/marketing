require 'test_helper'

class ProfessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @profession = professions(:one)
  end

  test "should get index" do
    get professions_url
    assert_response :success
  end

  test "should get new" do
    get new_profession_url
    assert_response :success
  end

  test "should create profession" do
    assert_difference('Profession.count') do
      post professions_url, params: { profession: { title: @profession.title } }
    end

    assert_redirected_to profession_url(Profession.last)
  end

  test "should show profession" do
    get profession_url(@profession)
    assert_response :success
  end

  test "should get edit" do
    get edit_profession_url(@profession)
    assert_response :success
  end

  test "should update profession" do
    patch profession_url(@profession), params: { profession: { title: @profession.title } }
    assert_redirected_to profession_url(@profession)
  end

  test "should destroy profession" do
    assert_difference('Profession.count', -1) do
      delete profession_url(@profession)
    end

    assert_redirected_to professions_url
  end
end
