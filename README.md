### Port Mapper Version 1
### Author: Rich Smith
### Date 2/10/2025

----------------------------------------------------------------------------------------------------------------------------------------

### Version 1 - 
  I think this is aligning somewhat with the intention of the CTF event, this script is designed to be fast through utilization
  of the `-T5` flag. It's also supposed to be accurate and give the user the ability to double check ports in the event that something
  is still missing. I'm not entirely certain how the event is planned to go, but I'm assuming we're not supposed to know which lights
  go with which ports, its simply an "is it open or is it closed" type scenario. I'm also assuming that there will be some kind of 
  stdout check that a port is open/closed rather than just a light being off. If not then we'd need some kind of photodetector, a piece
  of equipment that I'm only familiar with in my son's Snap Circuits toy set. In any event, the way this script is supposed to be used
  is through 2 sets of inputs, the first being an IPv4 address, and then the second an option from the proceeding case statement.
  Initially the user should select option 1 and do a custom scan, either from ports 1-65,535 or any assortment of port numbers. Doing a
  test on my own home network it took me about 17 seconds for the script to run when testing the whole 65,536 port range. Following this
  initial test comes a secondary test set, since I don't couldn't test on filtered services, and I don't know if that'll be apart of the
  challenge, I setup a filtered services file that would be created following the run of the second test. After that its going to come
  down to finding any missing ports and getting rid of any ports that slipped by on accident. The script does contain a filter for closed
  ports however as of 2/10/2025 I haven't set up a way to generate that list unless a smaller custom list is started from the beginning.

Any and all help for revision towards this would be appreciated.
