require 'station'

describe Station do

  describe '#name' do
    subject {Station.new('Baker Street', 1)}
    it 'returns the station name' do
      expect(subject.name).to eq('Baker Street')
    end
  end

  describe '#zone' do
    subject {Station.new('Baker Street', 1)}
    it 'returns the zone name' do
      expect(subject.zone).to eq(1)
    end
  end
end
