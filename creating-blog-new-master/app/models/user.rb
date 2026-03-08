class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  # :recoverable, :rememberable,
  devise :database_authenticatable, :registerable, :trackable, :validatable,
         authentication_keys: [:name]

  validates :name, presence: true, length: { maximum: 255 }, uniqueness: { case_sensitive: true }

  private

  # 登録時に email を不要にする
  def email_required?
    false
  end

  def email_changed?
    false
  end

  def will_save_change_to_email?
    false
  end

  # IPは保存しないので、オーバーライドしてIP機能のみ削除
  def update_tracked_fields(_request)
    old_current, new_current = self.current_sign_in_at, Time.now.utc
    self.last_sign_in_at     = old_current || new_current
    self.current_sign_in_at  = new_current

    # old_current, new_current = self.current_sign_in_ip, request.remote_ip
    # self.last_sign_in_ip     = old_current || new_current
    # self.current_sign_in_ip  = new_current

    self.sign_in_count ||= 0
    self.sign_in_count += 1
  end
end
