//try {
//      for (int i = 0; i < trx.length; i++) {
//        ArrayList<Note> trackAsList = new ArrayList<Note>();
//        tracks.add(trackAsList);
//        Track t = trx[i];
//        if (DO_PRINT) {
//          println("track ");
//          println("length:"+ t.ticks());
//          println("num events:" + t.size());
//        }
//        int counter = 0;
//        //iterate over the vector, and remove each handled event.
//        while (t.size () > 0 && counter < t.size()) {
//          counter ++;
//          if (t.get(0).getMessage() instanceof ShortMessage) {
// 
//            ShortMessage s = (ShortMessage)(t.get(0).getMessage());
//            //find note on events
//            if (s.getCommand() == ShortMessage.NOTE_ON) {
//              if (DO_PRINT)println(s.getCommand() + " " + s.getChannel() +" " + s.getData1() + " " + s.getData2());              
//              //store all the values temporarily in order to find the associated note off event
//              long startTime = t.get(0).getTick();
//              long endTime = 0;
//              int ch = s.getChannel();
//              int pitch = s.getData1();
//              int vel = s.getData2();
//              
//              //if the first note has zero velocity (== noteOff), remove it
//              if (vel == 0) {
//                t.remove(t.get(0));
//              } 
//              
//              else {
//                //start to look for the associated note off
//                for (int j = 0; j < t.size(); j++) {
//                  if (t.get(j).getMessage() instanceof ShortMessage) {
//                    ShortMessage s2 = (ShortMessage)(t.get(j).getMessage());
//                    //two types to send a note off... either as a clean command or as note on with 0 velocity
//                    if ((s2.getCommand() == ShortMessage.NOTE_OFF) || s2.getCommand() == ShortMessage.NOTE_ON) {
//                      //compare to stored values, sending a note off with same channel and pitch means to stop the note
//                      if (s2.getChannel() == ch && s2.getData1() == pitch && s2.getData2() == 0) {
//                        //calculate note duration
//                        endTime = t.get(j).getTick();
//                        //extend maxticks, so we know when the last midi event happened (sometimes tracks are much longer than the last note
//                        if (endTime > maxTicks)maxTicks = endTime;
//                        //create a new "Note" instance, store it
//                        Note n = new Note(startTime, endTime-startTime, ch, vel, pitch);
//                        trackAsList.add(n);
//                        t.remove(t.get(0));
//                        break;
//                      }
//                    }
//                  }
//                }
//              }
//              //remove event when done
//              t.remove(t.get(0));
//            }
//            else {
//              //remove events which are shortmessages but not note on (e.g. control change)
//              t.remove(t.get(0));
//            }
//          } 
//          else {
//            //remove events which are not of type short message
//            t.remove(t.get(0));
//          }
//        }
//      }
//    }
//    catch (Exception e) {
//      e.printStackTrace();
//    }
