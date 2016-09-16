class Series

	attr_accessor :sequence

	def initialize(seq)
		@sequence = seq.split("").map(&:to_i)
	end

	# Takes an integer of the length of the desired sub arrays to be returned from the sequence
	def slices(length)
    last = length - 1
		first = 0

    if last > sequence.length - 1
      raise ArgumentError, "Sub-sequence length must be <= given sequence"
    end

    sub_sequences = []
		while last < sequence.length
      sub_sequences << sequence.slice(first..last)
      first += 1
      last += 1
    end
    sub_sequences

	end

end