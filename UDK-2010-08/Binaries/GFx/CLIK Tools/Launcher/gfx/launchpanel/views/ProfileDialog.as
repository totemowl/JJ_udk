﻿import mx.controls.TextInput;import mx.controls.Button;import mx.utils.Delegate;import gfx.launchpanel.views.BaseDialog;class gfx.launchpanel.views.ProfileDialog extends BaseDialog {		// Constants:		public static var CLASS_REF = gfx.launchpanel.views.ProfileDialog;	public static var LINKAGE_ID:String = "ProfileDialog";		private var profileInput:TextInput;	private var saveBtn:Button;	private var cancelBtn:Button;		public function ProfileDialog() { super(); }		private function configUI():Void {		super.configUI();		saveBtn.addEventListener("click", Delegate.create(this, saveProfile));		cancelBtn.addEventListener("click", Delegate.create(this, close));	}		private function saveProfile(p_event:Object):Void {		dispatchEvent({type:"save",profileName:profileInput.text});	}	}