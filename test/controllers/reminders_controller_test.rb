require 'test_helper'

class RemindersControllerTest < ActionController::TestCase
  setup do
    @reminder = reminders(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:reminders)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create reminder" do
    assert_difference('Reminder.count') do
      post :create, reminder: { fq_interval: @reminder.fq_interval, fq_monthly_interval: @reminder.fq_monthly_interval, fq_time: @reminder.fq_time, fq_type: @reminder.fq_type, name: @reminder.name, user_id: @reminder.user_id }
    end

    assert_redirected_to reminder_path(assigns(:reminder))
  end

  test "should show reminder" do
    get :show, id: @reminder
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @reminder
    assert_response :success
  end

  test "should update reminder" do
    patch :update, id: @reminder, reminder: { fq_interval: @reminder.fq_interval, fq_monthly_interval: @reminder.fq_monthly_interval, fq_time: @reminder.fq_time, fq_type: @reminder.fq_type, name: @reminder.name, user_id: @reminder.user_id }
    assert_redirected_to reminder_path(assigns(:reminder))
  end

  test "should destroy reminder" do
    assert_difference('Reminder.count', -1) do
      delete :destroy, id: @reminder
    end

    assert_redirected_to reminders_path
  end
end
