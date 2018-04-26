require 'journey.rb'

describe Journey, :j do
  let(:station) { double :station, name: :name, zone: :zone }


  describe '#start_journey' do
    it 'Adds entry station name' do
      subject.start_journey(station)
      expect(subject.entry_station).to eq :name
    end
  end

  describe '#end_journey' do
    it 'Charges minimum fare for journey' do
      subject.start_journey(station)
      subject.end_journey(station)
      expect(subject.fare).to eq(Journey::MINIMUM_FARE)
    end

    it 'Adds exit_station name' do
      expect(subject.end_journey(station)).to eq :name
    end

    context 'Entry station is equal to nil' do
      it 'Charges penalty fare for journey without start' do
        subject.end_journey(station)
        expect(subject.fare).to eq(Journey::PENALTY_FARE)
      end
    end

    context 'Exit station is equal to nil' do
        it 'Charges penalty fare for starting journey after starting journey' do
          2.times { subject.start_journey(station) }
          expect(subject.fare).to eq (Journey::PENALTY_FARE)
        end
      end
    end

    describe '#complete?' do
      it 'shows not complete on initialize?' do
        expect(subject).to_not be_complete
      end

      it 'shows not complete after start journey' do
        subject.start_journey(station)
        expect(subject).to_not be_complete
      end

      it 'shows not complete after end_journey' do
        subject.end_journey(station)
        expect(subject).to_not be_complete
      end

      it 'shows complete after start and end journey' do
        subject.start_journey(station)
        subject.end_journey(station)
        expect(subject).to be_complete
      end
    end
end
