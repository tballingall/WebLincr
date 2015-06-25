#
class Album < ActiveRecord::Base
  belongs_to :user
  belongs_to :cover, class_name: :Picture, foreign_key: 'picture_id'
  has_many :pictures

  delegate :thumb_url, to: :cover, allow_nil: true

  validates :name,
            presence: true,
            uniqueness: { case_sensitive: false, scope: :user_id }

  # query: Returns whether the given picture if the cover for this album
  #
  # @return [Boolean]
  #
  def cover?(picture)
    cover == picture
  end
end
