class User < ActiveRecord::Base
  include Merit
  has_merit

  TEMP_EMAIL = 'change@me.com'
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :custom_timeoutable, :timeout_in => 30.minutes
  validates :name, :sex_id, presence: true
  validates :port, uniqueness: true
  belongs_to :major, foreign_key: :major_id
  belongs_to :sex, foreign_key: :sex_id
  has_many :record, -> { order "id asc" }
  #accepts_nested_attributes_for :sex, :allow_destroy => true
  #accepts_nested_attributes_for :major, :allow_destroy => true

  #Paperclip
  has_attached_file :avatar,
                    :styles => { :medium => "180x180#", :thumb => "100x100#" },
                    :default_url => ":style/default.gif",
                    :path => ":rails_root/public/uploads/images/:id_:style_:fingerprint.:extension",
                    :url => "/uploads/images/:id_:style_:fingerprint.:extension"

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
  validates_attachment_file_name :avatar, matches: [/png\Z/, /jpe?g\Z/]

  def self.find_for_oauth(auth, signed_in_resource = nil)

    # Get the identity and user if they exist
    identity = Identity.find_for_oauth(auth)
    user = identity.user
    if user.nil?

      # Get the existing user from email if the OAuth provider gives us an email
      user = User.where(:email => auth[:info][:email]).first if auth[:info][:email]

      # Create the user if it is a new registration
      if user.nil?
        user = User.create(
          name: auth[:extra][:raw_info][:name],
          sex_id: 1,
          major_id:11,
          #username: auth.info.nickname || auth.uid,
          email: auth[:info][:email].blank? ? TEMP_EMAIL : auth[:info][:email],
          password: Devise.friendly_token[0,20],
          score: 0
        )
      end

      # Associate the identity with the user if not already
      if identity.user != user
        identity.user = user
        identity.save!
      end
    end
    user
  end

  def admin?
    admin
  end
end