prawn_document(:filename => 'relatorio.pdf') do |pdf|
    header(pdf)
    enrollments_table(pdf, :enrollments => @enrollments)
end
