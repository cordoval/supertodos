class Todo < ActiveRecord::Base
  after_create  :send_create
  after_destroy :send_destroy
  after_update  :send_update

  private

  def send_create
    send_to_pusher :create
  end

  def send_destroy
    send_to_pusher :destroy
  end

  def send_update
    send_to_pusher :update
  end

  def send_to_pusher(method)
    Pusher['supertodos'].trigger("todos:#{method}", self.to_json)
  end
end
