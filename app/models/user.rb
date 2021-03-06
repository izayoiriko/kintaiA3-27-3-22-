class User < ApplicationRecord
  has_many :attendances, dependent: :destroy
  
  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 100 },
                    format: {with: VALID_EMAIL_REGEX},
                    uniqueness: true
  validates :affiliation, length: { in: 2..50 }, allow_blank: true # 空の場合スルー
  validates :designated_work_start_time, presence: true
  validates :basic_work_time, presence: true
  validates :designated_work_end_time, presence: true
  validates :employees_number, length: { in: 1..6 }, allow_blank: true
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true
  
  generate_public_uid generator: PublicUid::Generators::HexStringSecureRandom.new(7)
  
  # 渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end
  
  # ランダムなトークンを返す
  
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  # 永続セッションのためハッシュ化したトークンをデータベースに記憶します
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  
  # トークンがダイジェストと一致すればtrueを返す
  def authenticated?(remember_token)
    # ダイジェストが存在しない場合はfalseを返して終了します。
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
  
  # ユーザー情報を破棄
  def forget
    update_attribute(:remember_digest, nil)
  end
  
  def self.name_search(search)
    User.where(['name LIKE ?', "%#{search}%"])
  end
  
  # csv
  def self.import(file)
    CSV.foreach(file.path, headers: true) do |row|
      user = find_by(id: row[:id]) || new
      user.attributes = row.to_hash.slice(*updatable_attributes)
      user.save
    end
  end
    # 更新を許可するカラムを定義
  def self.updatable_attributes
    ["id", "name", "affiliation", "employees_number", "public_uid", "basic_work_time", "designated_work_start_time",
    "superior", "admin", "password","email"]
  end
end
