package com.knomedia.services
{
	public dynamic class ServiceParams
	{
		//public static const SERVICE_GATEWAY:String = "https://www.ce1.com/cgi-bin/form-proc-jmadsen.cgi";
		public static const SERVICE_GATEWAY:String = "https://www.ce1.com/cgi-bin/form-proc-ws.cgi";
		
		public var ws_id:String;
		public var ws_return:String = "JSON";
		public var ws_action:String;
		
		
		
		public var registration_id:String;
		
		//public var active_ws_id:String = "AABBCCDD1"; // test service
		public var active_ws_id:String = "KDJE83HW8"; // live service
		
		public function ServiceParams()
		{
		}
		
		
		/*
		
			ws_action types:
				authenticateUser
					Getting information about a registration:
					1.        Submit a request with the following information:
					a.       ws_id = special web service id assigned to this client/event combination
					b.      ws_return = “JSON” to return JSON format (case insensitive), anything else to return a text representation of the data
					c.       ws_action = “authenticateUser” (case sensitive)
					
					e.      registration_id = registration id with which this request is associated
		
				getAllPresentationData
					Getting information about all sessions/presentations:
					1.       Submit a request with the following information:
					a.       ws_id = special web service id assigned to this client/event combination
					b.      ws_return = “JSON” to return JSON format (case insensitive), anything else to return a text representation of the data
					c.       ws_action = “getAllPresentationData” (case sensitive)
		
							Note:  two of the fields given in return are
							“se_count” – this is the number of people currently registered for this session/presentation
							
							“se_limit” – this is the maximum people allowed to register for this session/presentation
							a.       “0” = unlimited number of people may register
							b.       Positive number  = the number of people who may register
							c.       Negative number = N/A
		
		
					Modify the information of the registration you are working with as needed, keeping in mind any “se_limit” that is not “0” (zero = unlimited).
					1.       If a session is no longer desired simply do not return that “se_session_id” information in the next step
					2.       If a new session is desired return that “se_session_id” with a value of “on” in the next step
					3.       Note that currently each person is required to register for a single “se_session_id” for every time slot of every day (this needs to be handled on your side as currently we handle it with code on the webpage itself.
					4.       The 7:30 AM Proctored Exams on each day are optional.
					
					Send a response to update the registration (NOTE: you must send every field originally received from the “authenticateUser” request back, including the unchanged fields as any field not received will be assumed to be blank and the previously existing information will be deleted):
					1.       Submit a request with the following information:
					a.       ws_id = special web service id assigned to this client/event combination
					b.      ws_return = “JSON” to return JSON format (case insensitive), anything else to return a text representation of the data
					c.       ws_action = “changeRegistration” (case sensitive)
				
					e.      registration_id = registration id with which this request is associated
					f.        (all fields received from the “authenticateUser” request – changed OR unchanged)
		
		*/
	}
}