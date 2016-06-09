class Card < ActiveRecord::Base
  validates :topic_id, presence: true
  validates :cardname, presence: true
  validates :card_data, presence: true
  # validates :card_file, presence: true
  # validate :file_size_under_ten_mb
  
	belongs_to :topic
	
#   def initialize(params = {})
#     @file = params.delete(:card_file)
#     super
#     if @file
#       self.cardname = sanitize_filename(@file.original_filename)
#       self.content_type = @file.content_type
#       self.card_file = @file.read
#     end
#   end

# TEN_MEGABYTES = 10485760
# def file_size_under_ten_mb
#   if (@file.size.to_f / TEN_MEGABYTEs) > 1
#     errors.add(:file, 'The size of the file should not be over 10mb!')
#   end
# end

# private
#   def sanitize_filename(cardname)
#     return File.basename(cardname)
#   end
end
