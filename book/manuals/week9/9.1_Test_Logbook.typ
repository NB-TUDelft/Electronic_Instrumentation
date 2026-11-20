#import "../logbook_common.typ": *

#show: logbook.with(
  title: "Log Book Entry 9.1",
  subtitle: "Test entry, will be removed",
)

#section("MEASUREMENTS", note: "Task I1")
#prompt[Measure something.]
#nosuchfunction()
#field_row([Value:], line_field("i1_value"))

#closing(graph: false)
