FactoryBot.define do
  factory :talk do
    topic { 'Africa can lead the world. But, will we?' }
    video_url { '/dummyyoutubevideourl' }
    date { Date.new }
    event { build(:event, :published) }
    speaker
  end
end
