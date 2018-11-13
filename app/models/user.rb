# frozen_string_literal: true

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :evaluations
  has_many :workshops, through: :evaluations
  has_many :feedbacks

  validates :name, presence: true
  validates :surname, presence: true
  validates_presence_of :cpf

  with_options allow_blank: true do |v|
    v.validates_uniqueness_of :cpf
    validates :cpf, format: { with: /([0-9]{2}[\.]?[0-9]{3}[\.]?[0-9]{3}[\/]?[0-9]{4}[-]?[0-9]{2})|([0-9]{3}[\.]?[0-9]{3}[\.]?[0-9]{3}[-]?[0-9]{2})/ }
  end
  def turnIntoAdmin
    self.role_id = Role.find_by(name: 'Admin').id
  end

  def turnIntoUser
    self.role_id = Role.find_by(name: 'Supervisor').id
  end

  def turnIntoSupervisor
    self.role_id = Role.find_by(name: 'User').id
  end
end
