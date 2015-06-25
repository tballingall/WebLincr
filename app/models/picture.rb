#
class Picture < ActiveRecord::Base
  dragonfly_accessor :image
  belongs_to :album
  delegate :user, to: :album
  validates :name, presence: true
  validates :image, presence: true

  after_create :maybe_primary

  # query: Returns the url for an image thumb
  #
  # @return [String]
  #
  def thumb_url
    image.thumb('400x200#').url
  end

  private

  def maybe_primary
    return self if album.cover.present?
    album.update_attributes(cover: self)
    self
  end
end