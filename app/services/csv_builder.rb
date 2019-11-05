class CsvBuilder < ServiceCaller
  def initialize(room)
    @room = room
  end

  def call
    @report = @room.report

    @result = CSV.generate(headers: true) do |csv|
      csv << @report[:header][:name]
      csv << @report[:header][:money]

      @report[:body].each do |record|
        temp_array = []
        temp_array << record['date']
        @report[:header][:id].each do |id|
          temp_array << record[id]
        end
        temp_array << record['recorder']
        csv << temp_array
      end
    end
  end
end