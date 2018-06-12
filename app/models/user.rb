class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :todo_lists, dependent: :destroy

  validates :email, presence: true

  def as_json(options={})
    token = create_token(options)
    super(options).merge({token: token})
  end

  def create_token(options)
    JWTWrapper.encode({"user_id"=>id.to_s})
  end
end
