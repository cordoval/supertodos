class Todo < ActiveRecord::Base
  after_create :send_to_pusher

  private

  def send_to_pusher
    Pusher['supertodos'].trigger("todo:create", self.to_json)
  end
end
