/** * com.sekati.thinkgear.data.EEGPower * @version 1.0.0 * @author jason m horwitz | sekati.com * Copyright (C) 2010  jason m horwitz, Sekat LLC. All Rights Reserved. * Released under the MIT License: http://www.opensource.org/licenses/mit-license.php *  * Derrivative of kannopy thinkgear api. */package com.sekati.thinkgear.data {	/**	 * EEGPower represents a single unit of EEG Power (amplitude) data for a Band (frequency).	 * 	 * @see http://developer.neurosky.com/docs/doku.php?id=what_is_thinkgear	 * @see http://developer.neurosky.com/docs/doku.php?id=eeg_band_powers	 * @see http://support.neurosky.com/faqs/technology/eeg-band-frequencies	 * @see http://support.neurosky.com/faqs/development-2/eeg-band-power-values-units-and-meaning	 */	final public class EEGPower {		/**		 * The low end of the EEG Power data unit.		 */		public var low : Number;		/**		 * The high end of the EEG Power data unit.		 */		public var high : Number;		/**		 * EEGPower Constructor		 */		public function EEGPower() {			super( );		}	}}