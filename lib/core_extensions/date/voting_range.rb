module CoreExtensions
  module Date
    module VotingRange
      def last_friday
        friday = beginning_of_week(:friday)
        self == friday ? friday - 7 : friday
      end
    end
  end
end
