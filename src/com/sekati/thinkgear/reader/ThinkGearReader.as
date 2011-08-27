/** * com.sekati.thinkgear.reader.ThinkGearReader * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2010  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php *  * Derrivative of kannopy thinkgear api. */package com.sekati.thinkgear.reader {	import com.sekati.thinkgear.data.EEGPowers;	import com.sekati.thinkgear.data.ESenseData;	import com.sekati.thinkgear.data.SignalQuality;	import com.sekati.thinkgear.data.ThinkGearByteType;	import com.sekati.thinkgear.events.EEGPowersEvent;	import com.sekati.thinkgear.events.ESenseDataEvent;	import com.sekati.thinkgear.events.SignalQualityEvent;		import flash.events.EventDispatcher;	import flash.utils.ByteArray;	import flash.utils.Endian;		/**	 * ThinkGearReader reads raw <code>ByteArray</code> data from the ThinkGear Connector (TGC) buffer & 	 * dispatches events as data is received. This is a faster approach to what the documentation suggests	 * which is configuring the TGC to output <code>JSON</code> over the socket; creating load on both ends	 * as it necessitates serialization and deserialization.	 * 	 * Exposes properties available through the ThinkGear Connector API.	 * 	 * @see http://developer.neurosky.com/docs/lib/exe/fetch.php?media=app_notes:thinkgear_socket_protocol.pdf	 */	final public class ThinkGearReader extends EventDispatcher {				/**		 * Dispatched to inform client that signal quality data has been captured from the ThinkGear BCI.		 */		[Event(name="signalQualityData", type="com.sekati.thinkgear.events.SignalQualityEvent")]		/**		 * Dispatched to inform client that attention and meditation data has been captured from the ThinkGear BCI.		 */		[Event(name="eSenseData", type="com.sekati.thinkgear.events.ESenseDataEvent")]		/**		 * Dispatched to inform client that EEG Power data has been captured from the ThinkGear BCI.		 */		[Event(name="eegPowersData", type="com.sekati.thinkgear.events.EEGPowersEvent")]		/*** @private */		private var _buffer : ByteArray;		/*** @private */		private var _signalQuality : SignalQuality;		/*** @private */		private var _eSenseData : ESenseData;		/*** @private */		private var _eegPowers : EEGPowers;		/**		 * ThinkGearReader Constructor		 */		public function ThinkGearReader() {			super( );			initialize( );		}		/**		 * Create the internal ByteArray used as the data buffer. Set the buffer's properties.		 * Initialize data objects that will be populated from the BCI buffer data.		 */		private function initialize() : void {			buffer = new ByteArray( );			buffer.position = 1;			buffer.endian = Endian.BIG_ENDIAN;        				signalQuality = new SignalQuality( );			eegPowers = new EEGPowers( );			eSenseData = new ESenseData( );		}		/**		 * Processes the buffer containing data being transmitted by the ThinkGear BCI.		 */		public function read() : void {    			while ( twoBytesSeen( ) ) {				continue;			}			while ( isNotEndOfBuffer( ) ) {				processByte( );			}			dispatchEvents( );			initialize( );		}		/**		 * Notify any registered objects that updated data 		 * has been captured from the ThinkGear BCI. 		 */		private function dispatchEvents() : void {			dispatchEvent( new SignalQualityEvent( signalQuality ) ); 			dispatchEvent( new ESenseDataEvent( eSenseData ) ); 			dispatchEvent( new EEGPowersEvent( eegPowers ) );		}		/**		 * Checks to see if two consecutive SYNC (0xAA) bytes have been read.		 */		private function twoBytesSeen() : Boolean {			return ( isNotEndOfBuffer( ) && currentByteIsNotSyncByte( ) && lastByteIsNotSyncByte( ) ); 		}   		/**		 * Checks the current position in the buffer to ensure the end of it hasn't been reached.		 */		private function isNotEndOfBuffer() : Boolean {			return buffer.position < buffer.length;		}		/**		 * Checks the current byte being read to see if it's a SYNC (0xAA) byte.		 */		private function currentByteIsNotSyncByte() : Boolean {			var currentByte : uint = buffer.readUnsignedByte( );			return byteIsNotSyncByte( currentByte );		}		/**		 * Checks the previously processed byte to see if it's a SYNC (0xAA) byte.		 */		private function lastByteIsNotSyncByte() : Boolean {			var bufferPosition : int = buffer.position;			var lastByte : uint = this[ bufferPosition - 1 ];			return byteIsNotSyncByte( lastByte );		}		/**		 * Checks a byte to see if it's are SYNC (0xAA) byte.		 */		private function byteIsNotSyncByte( byte : uint ) : Boolean {			return byte != ThinkGearByteType.SYNC_BYTE;		}		/**		 * Processes a byte to determine type. Processes next byte to update 		 * appropriate object with byte data.		 */		private function processByte() : void {			var codeByte : uint = buffer.readUnsignedByte( );			var dataByte : uint = buffer.readUnsignedByte( );			if ( ThinkGearByteType.isSignalQualityByte( codeByte ) ) {				signalQuality.quality = dataByte;			}            else if ( ThinkGearByteType.isAttentionByte( codeByte ) ) {				eSenseData.attention = dataByte;			}            else if ( ThinkGearByteType.isMeditationByte( codeByte ) ) {				eSenseData.meditation = dataByte;			}            else if ( ThinkGearByteType.isEEGPowersByte( codeByte ) ) {				// EEG powers - read the length, and eight floats (8 * 4 bytes)				//var lengthByte : Number = dataByte;				eegPowers.parseEEGPowers( buffer );			}		}				/**		 * Internal buffer used to read byte data from the ThinkGear Connector (TGC).		 */		public function get buffer() : ByteArray {			return _buffer;		}		/*** @private */		public function set buffer(buffer : ByteArray) : void {			_buffer = buffer;		}			/**		 * The strength of the connection from the ThinkGear BCI hardware 		 * device to the computer running the ThinkGear Connector (TGC).		 */		public function get signalQuality() : SignalQuality {			return _signalQuality;		}		/*** @private */		public function set signalQuality( signalQuality : SignalQuality ) : void {			_signalQuality = signalQuality;		}		/**		 * Object containing the Attention and Meditation 		 * data being transmitted by the ThinkGear BCI. 		 */		public function get eSenseData() : ESenseData {			return _eSenseData;		}		/*** @private */		public function set eSenseData(eSenseData : ESenseData) : void {			_eSenseData = eSenseData;		}		/**		 * Object containing the EEG Powers data being 		 * transmitted by the ThinkGear BCI.		 */		public function get eegPowers() : EEGPowers {			return _eegPowers;		}		/*** @private */		public function set eegPowers(eegPowers : EEGPowers) : void {			_eegPowers = eegPowers;		}			}}