
===  SEKATI Thinkgear BCI (Brain-Computer Interface) AS3 API ===

Version: 1.1.0
Developer: Jason M Horwitz / Sekati
Website: http://sekati.com
Copyright: © 2010-2011 Jason M Horwitz, Sekati LLC.
Tags: BCI, brain computer interface, physical computing, Air, actionscript, AS3, neurosky, EEG

I. Description

	SK Thinkgear is an AS3 framework for working with NeuroSky's "Thinkgear" EEG Headsets. 
	Thanks to their open architecture BCI (brain-computer interface) devices we can easily 
	read raw EEG powers data & parse algorithmic reading abstractions performed by the hardware.


II. Requirements
	
	Demo / Experiment:

	- Thinkgear Mindset (EEG Headset): http://www.neurosky.com/Products/MindSet.aspx
	- ThinkGear Connector: http://developer.neurosky.com/docs/doku.php?id=thinkgear_connector_tgc

	Build:
	
	- FDT/Eclipse or Flex/FlashBuilder
	- Sekati API SWC Library: http://sekati.googlecode.com
	- Tweener SWC Library: http://tweener.googlecode.com
	- AS3CoreLib SWC Library: https://github.com/mikechambers/as3corelib


III. Documentation
	
	Specific attention has been paid to writing thorough and concise Documentation for 
	the API which is shipped with the repo & hosted for easy reference.
	
	Documentation:		http://code.sekati.com/docs/thinkgear/

	
IV. License

	Released under the MIT License: http://www.opensource.org/licenses/mit-license.php


V. Notes
	
	A note on launch profiles: most mxmlc building profiles are best run from Eclipse
	with FDT (v3 or v4) or Flex/FlashBuilder via the Eclipse menu:
	"Run->Debug Configuration" FDT menu, however the ASDoc profile should be
	launched from "Run->External Tools->External Tools Configuration..." menu and
	similarly the Air launch profile needs to be run from the 
	"Run->Run Configurations" menu.