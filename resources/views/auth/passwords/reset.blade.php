@extends('layout')

@section('content')
<div class="container">
    <div class="row">
        <div class="col-md-8 col-md-offset-2">
            <div class="panel panel-default">
                <div class="panel-heading">Reset Password</div>

                <div class="panel-body">
                    <form class="form-horizontal" role="form" method="POST" action="{{ url('/password/reset') }}">
                        {{ csrf_field() }}

                        <input type="hidden" name="token" value="{{ $token }}">

                        <div class="form-group{{ $errors->has('email') ? ' has-error' : '' }}">
                            <label for="email" class="col-md-4 control-label">E-Mail Address</label>

                            <div class="col-md-6">
                                <input id="email" type="email" class="form-control" name="email" value="{{ $email or old('email') }}" required autofocus>

                                @if ($errors->has('email'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('email') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>

                        <div class="form-group{{ $errors->has('password') ? ' has-error' : '' }}">
                            <label for="password" class="col-md-4 control-label">Password</label>

                            <div class="col-md-6">
                                <input id="password" type="password" class="form-control" name="password" required>

                                @if ($errors->has('password'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('password') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>

                        <div class="form-group{{ $errors->has('password_confirmation') ? ' has-error' : '' }}">
                            <label for="password-confirm" class="col-md-4 control-label">Confirm Password</label>
                            <div class="col-md-6">
                                <input id="password-confirm" type="password" class="form-control" name="password_confirmation" required>

                                @if ($errors->has('password_confirmation'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('password_confirmation') }}</strong>
                                    </span>
                                @endif
                            </div>
                        </div>
                        @if ($email)
                        <div>
                            <h1>Terms of Service</h1>

                            <div>

                                <p>
                                    Please read this agreement carefully. By accessing or using all or any portion of this service or by paying for the service by any means offered by PunchCard,LLC, you accept all the terms and conditions of this agreement. You agree that this agreement is enforceable like any written negotiated agreement signed by you.
                                </p>

                                <p>

                                    The terms and conditions of this agreement (“Terms & Conditions”) apply to any and all use of the service by you, whether you are using the service pursuant to any demo period, beta period, or the term of this agreement and you agree to be bound by these terms and conditions regardless of the type of use of the service by you. This agreement, as amended from time to time (the "Agreement") is between you ("you", "your", "Client") and PunchCard, LLCInc. including its authorized suppliers ("PunchCard, LLC"). The Service and other capitalized terms used in this Agreement are defined in a Section at the end of this Agreement.                  

                                </p>

                                <p>Hosted Service</p>

                                <p>
                                    PunchCard, LLCwill provide and Client andits authorized Users will have access to the Service during theTerm, subject to the Terms and Conditions. Subject to Client's compliance with its obligations under this Agreement, PunchCard, LLChereby grants Client a non-exclusive license to: (i) accessand execute the Software on PunchCard, LLC's application server over the Internet; (ii) use the Documentation related to the Software or the other components of the Service; (iii) transmit data related to Client's use of the Software to and from PunchCard, LLC's application server over the Internet and store such data on PunchCard, LLC's application server; and (iv) access and use PunchCard, LLC's User interface on its website.

                                </p>

                                <p style="text-align:center">PunchCard, LLC’sTerms of Use</p>

                                <p>
                                    You may not access the Service if youare a direct competitor of PunchCard, LLC, except with PunchCard, LLC's prior written consent. In addition, you may not access the Service for purposes of monitoring its availability, performance or functionality, or for any other benchmarking or competitive purposes.

                                </p>

                                <p>
                                    Client will be responsible for all equipment and software required for Client to access the Internet including, without limitation, a web browser compatible with the PunchCard, LLCService.

                                </p>

                                <p>
                                    Client agrees that its use of the Service will be in a manner consistent with this Agreement and with all applicable laws and regulations, including without limitation, all copyright, trademark, patent, trade secret and export control laws, as well as those laws prohibiting the use of telecommunications facilities to transmit illegal, obscene, threatening, harassing, or other offensive messages. Client acknowledges that PunchCard, LLCis not responsible for any use or misuse of the Service by Client or its employees or contractors. In particular, Client will not, nor shall it permit or assist others, to abuse or fraudulently use the Service, including but not limited to: (i) obtaining or attempting to obtain Service by any unauthorized means or device with intent to avoid payments; (ii) accessing, altering,or destroying any information belonging to any person other than Client, or attempting to do so; and (iii) using the Service to interfere with the use of similar Service by other companies or users.

                                </p>
                                <p>Use and Access</p>
                                <p> 
                                    Subject to the restrictions on use as set forth herein, Client will have access to the Service for its intended purpose and in accordance with the specifications set forth in any Documentation relating to the Service or Software provided by PunchCard, LLC.Such use and access will be continuous on a twenty four (24) hour a day, seven (7) day a week basis except for interruptions by reason of maintenance or downtime beyond PunchCard, LLC's reasonable control.

                                </p>

                                <p>
                                    Client will use the Service only for its internal business operations and will not permit the Service to be used by or for the benefit of anyone other than Client. Client will not have the right to re-license or sell rights to access and/or use the Service to transfer or assign rights to access or use the Service, except as expressly provided herein. Client may not modify, translate, reverse engineer, decompile or create derivative works based upon the Software. Client agrees to use the Service in a manner that complies with all applicable laws includingintellectual property and copyright laws. PunchCard, LLCexpressly reserves all rights not expressly granted to Client here in.
                                </p>

                                <p>
                                    Client will not: (i) transmit or share identification or password codes to persons other than authorized Users; (ii) permit theidentification or password codes to be cached in proxy servers and accessed by individuals who are not authorized Users; or (iii) permit access to the Service through a single identification or password code being made available to multiple users on a network.Price and Payment
                                </p>

                                <p>
                                    Client shall pay all fees or charges accruing to your account in accordance with the fees, charges, and billing terms in effect at the time a fee or charge is due and payable. The charges will be equal to the number of total Users multiplied by the User Fee in effect. Payments will be made in advance and may be made annually, quarterly or monthly, or as otherwise mutually agreed upon. All payment obligations are non-cancellable and all amounts paid are non-refundable. You are responsible for paying for all User Fees for Users ordered for the entire Term, whether or not such Users actually use the Service. You must provide PunchCard,LLCwith valid credit card or approved purchase order information as a condition to getting access to the Service. You may add Users by paying the applicable User Fee. Added Users will be subject to the following: (i) the term of use for such Users will be coterminous with the pre-existing Term; (ii) the fee for the added Users will be the then current, generally applicable User Fee; and (iii) Users added in the middle of a billing period will be charged in full for that billing period. PunchCard, LLCreserves the right to modify its fees and charges and to introduce new charges at any time, upon at least 30 days prior notice to you, which notice may be provided by e-mail. Fees for other services will be charged on an as quoted basis. All pricing terms are confidential, and you agree not to disclose them to any third party.Warranty and Disclaimer
                                </p>
                                <p>
                                    PunchCard, LLCwarrants the Service will be provided in conformity with generally prevailing industry standards. Client must report any material deficiencies in the Service to PunchCard, LLCin writing within thirty (30) days of Client's discovery of the defect. Client's exclusive remedy for the breach of the above warranty will be for PunchCard, LLCto use commercially reasonable efforts to provide the Service in accordance with this Agreement. If the breach involves the Software, Client's exclusive remedy will be for PunchCard, LLCto provide access to replacement software, for the Software that is materially deficient, within a commercially reasonable time. To the maximum extent permitted by law, this warranty is exclusive and is in lieu of all other warranties, whether express or implied, statutory, or of merchantability or fitness for a particular purpose or non-infringement of third party rights or any oral or written representations, proposals, or statements made on or prior to the effective date of this agreement. PunchCard, LLCExpressly Disclaims All Other Warranties.Limitation of Liability
                                </p>
                                <p>
                                    To the maximum extent permitted by applicable law, except for PunchCard, LLC's willful misconduct or gross negligence, PunchCard, LLChereby excludes for itself and its suppliers any liability in excess of the fees paid by client to PunchCard, LLC, during the twelve (12) month period immediately preceding the occurrence or act or omission giving rise to the claim (the "compensation amount"), howsoever caused, whether based in contract or tort (including negligence), product liability or otherwise. PunchCard, LLCshall not be liable for any incidental, consequential, indirect, special, exemplary or punitive damages of any kind, or for loss of revenue or profits or investment or the like, loss of business, loss of information or data, of other financial loss or personal injury arising out of or in connection with the sale, maintenance, use, performance, failure, or interruption of the software, even if client or its authorized representative has been advised of the possibility of such damages.
                                </p>
                                <p>
                                    To the maximum extent permitted by applicable law, except for PunchCard, LLC's willful misconduct or gross negligence, PunchCard, LLChereby excludes for itself and its suppliers any liability in excess of the fees paid by client to PunchCard, LLC, during the twelve (12) month period immediately preceding the occurrence or act or omission giving rise to the claim (the "compensation amount"), howsoever caused, whether based in contract or tort (including negligence), product liability or otherwise. PunchCard, LLCshall not be liable for any incidental, consequential, indirect, special, exemplary or punitive damages of any kind, or for loss of revenue or profits or investment or the like, loss of business, loss of information or data, of other financial loss or personal injury arising out of or in connection with the sale, maintenance, use, performance, failure, or interruption of the software, even if client or its authorized representative has been advised of the possibility of such damages.
                                </p>
                                <p>
                                    In the event any exclusion, limitation or other provision contained in this agreement shall be held to be invalid for any reason and PunchCard, LLCbecomes liable for loss or damage, such liability is limited to the compensation amount and no more.
                                </p>
                                <p>
                                    You agree to provide PunchCard, LLCwith complete and accurate billing and contact information. This information includes your legal company name, street address, e-mail address, and name and telephone number of a Service Administrator who will be responsible for and authorized to make all decisions concerning the Service on your behalf including act as a billing contact. You agree to update this information within thirty (30) days of any change to it. If the contact information you have provided is false or fraudulent, PunchCard, LLCreserves the right to terminate your access to the Service in addition to any other legal remedies.
                                </p>
                                <p>
                                    If you believe your bill is incorrect, youmust contact PunchCard, LLCin writing within forty five (45) days of the date of the invoice containing the amount in question to be eligible to receive an adjustment or credit.
                                </p>
                                <p>
                                    PunchCard, LLC's fees are exclusive of all taxes, levies, or duties imposed by taxing authorities, and you shall be responsible for payment of all such taxes, levies, or duties, excluding only taxes based solely on PunchCard, LLC's income. If PunchCard, LLCis required to pay or collect any federal, state, local, or value-added tax on any fees charged under this Agreement, or any other similar taxes or duties levied by any governmental authority, excluding taxes levied on PunchCard, LLC's net income, then such taxes and/or duties will be billed to and paid by Client immediately upon receipt of PunchCard, LLC's invoice and supporting documentation for the taxes or duties charged.
                                </p>
                                <p>
                                    Technical support is described in detail on the attached Schedule A (Service Level Agreement).
                                   
                                </p>
                                <p>
                                    <b>
                                    Term and Termination
                                    </b>
                                </p>
                                <p>
                                    The term of this Agreement will commence the day the web site interface for the Service is accessible to you via the Internet, and will continue for a period of one year, quarter or month, as selected by the Client or for such other initial term as otherwise mutually agreed upon (the "Term"). Thereafter this Agreement will automatically renew for successive periods of the same duration as the initial Term ("Renewal Term") unless either party gives the other party not fewer than thirty (30) days notice of its intent not to renew, or unless terminated earlier under the terms contained within this Agreement.
                                </p>
                                <p>
                                    Either party may terminate this Agreement for material breach, by the other party, provided, however, thatthe terminating party has given the other party at least twenty-one (21) days written notice of and the opportunity to cure the breach. Termination for breach will not preclude the terminating party from exercising any other remedies for breach available to it under law.Confidentiality and Privacy
                                </p>
                                <p>
                                    Client acknowledges that the Software, other Service components and other data and software on PunchCard, LLC's application server embodies logic, design and coding methodology that constitute valuable confidential information that is proprietary to PunchCard, LLC. Client will safeguard the right to access the Service, the Software and other software installed on PunchCard, LLC's application server using the same standard of care that Client uses for its own confidential materials but at least a reasonable standard of care.
                                </p>
                                <p>
                                    Subject to PunchCard, LLC's license to use Anonymous Data, all data or information pertaining to a specific Client and transmitted to or from or stored on PunchCard, LLC's application server in connection with the performance of this Agreement will be held as confidential by PunchCard, LLCand will not, without the prior written consent of Client, be disclosed or be used for any purposes other than the performance of this Agreement. PunchCard, LLCwill safeguard the confidentiality of such data or information using the same standard of care that PunchCard, LLCuses for its own confidential materials but at least a reasonable standard of care. This obligation does not apply to data or information that: (i) is or becomes, through no act or failure to act on the part of PunchCard, LLC, generally known or available to the public; (ii) is known by PunchCard, LLCat the time of receiving such information as evidenced by its written records; (iii) is hereafter furnished to PunchCard, LLCby a third party, as a matter of right and without restriction on disclosure; (iv) is independently developed by PunchCard, LLCas evidenced by its written and dated records and without any breach of this Agreement; or (v) is the subject of a written permission to disclose provided by Client.
                                    <br/>
                                    Further notwithstanding the forgoing, disclosure of data or information will not be precluded if such disclosure: (i) is in response to a valid order of a court or other governmental body of the United States; (ii) is otherwise required by law; or (iii) is otherwise necessary to establish rights or enforce obligations under this Agreement, but only to the extent that any such disclosure is necessary.
                                </p>
                                <p>
                                    Personal Information will be collected, used, retained and disclosed by PunchCard, LLCas outlined in PunchCard, LLC's privacy policy (the "Privacy Policy") that is posted, amended and updated from time to time as a link from the Service. Client will not do, or omit to do, anything in breach of, or contrary to the provisions of the Privacy Policy, as amended by PunchCard, LLCfrom time to time. Use of the Service or any component thereof will constitute electronic acceptance of the Privacy Policy as amended as of the time of such use. Any inquiries related to the Privacy Policy should be directed to PunchCard, LLC. Client warrants and represents that Client is in compliance, and will fully comply, with all applicable Privacy Laws and will take all steps reasonably within Client's power to ensure that Client's employees, contractors or customers comply with all applicable Privacy Laws.
                                </p>
                                <p>
                                    Indemnity of Licensee
                                </p>
                                <p>
                                    Client agrees to indemnify and hold harmless PunchCard, LLC, its affiliates, officers, directors, employees, agents, contractors, representatives, successors and assigns from and against any and claims, proceedings, actions or demands which may be brought against PunchCard, LLCor another of the indemnified parties and agree to indemnify and hold PunchCard, LLCand the other indemnified parties harmless from and against, any and all losses, damages, liabilities, costs and expenses (including, but not limited to, reasonable attorneys' fees) real or perceived, that occur, or that PunchCard, LLCmay suffer, sustain or incur, as a result of: (a) client's use of the services, or (b) client's breaches of this agreement. Client will have sole control of the investigation, preparation, defense and settlement of any such infringement claims and PunchCard, LLCshall make reasonable efforts to provide cooperation and assistance in any such investigation, preparation, defense and settlement. PunchCard, LLCmay engage separate counsel to monitor the defense at PunchCard, LLC's sole cost and expense.
                                </p>
                                <p>
                                    <b>
                                    Relation of Parties
                                    </b>
                                </p>
                                <p>
                                    Nothing in this agreement will create or imply an agency relationship between the parties, nor will this agreement be deemed to constitute a joint venture or partnership between the parties.The arbitration will be held in United States. Judgment on any award rendered by the arbitrator may be entered in any court of competent jurisdiction.
                                </p>
                                <p>
                                    <b>
                                    Attorneys' Fees
                                    </b>
                                </p>
                                <p>
                                    If any litigation or arbitration is necessary to enforce the terms of this agreement, the prevailing party will be entitled to reasonable attorneys' fees and costs.
                                </p>
                                <p>
                                    <b>
                                    Severability
                                    </b>
                                </p>
                                <p>
                                    If any term of this agreement is found to be unenforceable or contrary to law, it will be modified to the least extent necessary to make it enforceable, and the remaining portions of this agreement will remain in full force and effect.
                                </p>
                                <p>
                                    <b>
                                    Force Majeure
                                    </b>
                                </p>
                                <p>
                                    Neither party will be held responsible for any delay or failure in performance of any part of this agreement to the extent that such delay is caused by events or circumstances beyond the delayed party's reasonable control. Lack of funds does not entitle a party to claim force majeure.<br/>Waiver and Modification
                                </p>
                                <p>
                                    The waiver by any party of any breach of covenant will not be construed to be a waiver of any succeeding breach or any other covenant. All waivers must be in writing, and signed by the party waiving its rights. This agreement may be modified only by a written instrument executed by authorized representatives of the parties hereto.
                                </p>
                                <p>
                                    <b>
                                    Entire Agreement 
                                    </b>
                                </p>
                                <P>
                                    This agreement constitutes the entire agreement between the parties with respect to its subject matter, and supersedes all prior agreements, proposals, negotiations, representations or communications relating to the subject matter. Both parties acknowledge that they havenot been induced to enter into this agreement by any representations or promises not specifically stated herein.
                                </P>
                                <p>
                                    <b>
                                    Amendments  
                                    </b>
                                </p>
                                <p>
                                    PunchCard, LLCmay amend this agreement by giving you 30 days notice of the proposed amendments, which notice may be provided bye-mail. PunchCard, LLCmay periodically amend this agreement, as contemplated above, for any purpose including, without limitation, changing fees or charges for use of the service or restricting the amount of data you can store on the service or to implement a charge for data storage or for data storage in excess of certain amounts.<br/>Definitions
                                </p>
                                <P>
                                    The words and phrases used in this agreement, the initial letters of which are capitalized have the following meanings:
                                </P>
                                <p>
                                    "documentation" means all documents or information in any form pertaining to PunchCard, LLC's software, website or user website interface or other components of the service and provided to or developed by client from time to time;"downtime credit" has the meaning specified in schedule a;"personal information" means any information about an identifiable individual but does not include aggregate or anonymous information, or information used only to contact an individual in their capacity or position as an employee or official of an organization;"privacy laws" means any statute, legislation, regulation, or ruling, directive or order, of any government, legislature, parliament, regulatory authority, governmental department, agency, commission, board, tribunal, crown corporation, or court or other law, rule or regulation making entity having or purporting to have jurisdiction on behalf of any nation, or province or state or other subdivision thereof, or any municipality, district or other subdivision thereof, with respect to individual privacy and/or access to personal information, and with respect to the collection, use or disclosure of personal information, and having or purporting to have jurisdiction over any person, including client or any user;"renewal term" has the meaning specified in section 5;"service" means the right to access and use PunchCard, LLC's software, website, user website interface and related documentation;"software" means the PunchCard, LLCproduct licensed for use by client as specified in this agreement or as client may order and pay for from time to time or as may be modified from time to time by PunchCard, LLC;"term" has the meaning specified in section 5 or any renewal term;"unit" hasthe meaning specified in schedule "a";"user" means client's individual employee or contractor for whom client has: (a) paid the required fee under this agreement; (b) given or authorized a password to be given to such individual entitling them to access and use the service; or (c) for whom client is responsible to ensure that such individual observes the obligations of client under this agreement; and"user fee" means PunchCard, LLC's then current fee for one of client's users to access and use the service for the then current term.
                                </p>
                                <p>
                                    <b>
                                        Service Level Agreement
                                    </b>
                                </p>
                                <p>
                                    This service level agreement ("agreement") sets forth the details regarding the level of service and technical support for the service that apply when your account is in good financial standing.
                                </p>
                                <p>
                                    <b>
                                        Downtime
                                    </b>
                                </p>
                                <p>
                                    For purposes of this agreement, a unit of downtime is one period of at least thirty (30) minutes ("unit") during which the service or a material components of it is unavailable because of problems with or the unscheduled maintenance of PunchCard, LLC's hardware or system software ("downtime"). Downtime does not include (i) problems caused by factors outside of PunchCard, LLC's reasonable control, (ii) problems resulting from any actions or inactions by you or any third party, (iii) problems resulting from your equipment and/or third party equipment not within PunchCard, LLC's sole control, or (iv) network unavailability during scheduled maintenance of PunchCard, LLC's network and/or servers. PunchCard, LLCwill periodically monitor PunchCard, LLCnetwork and server availability using software and hardware components capable of measuring application traffic and responses. Based on its monitoring, PunchCard, LLCwill determine downtime for the purposes of this agreement.
                                </p>
                                <P>
                                    PunchCard, LLC's servers connect to the internet through redundant high-speed connections on diverse backbones, enabling data delivery to the end user in a quick and efficient manner. Subject to the limitations set out below, in any calendar month, PunchCard, LLCguarantees that downtime will not exceed eight (8) units of downtime excluding, however, regularly scheduled maintenance. Any regularly scheduled maintenance will be performed during the hours of 11:00 pm and 5:00 pm EST on a Saturday or Sunday. PunchCard, LLCworks to ensure the functioning of all network infrastructures through continuous monitoring by PunchCard, LLC's staff, however, PunchCard, LLChas no control over third party services including, without limitation, the internet and PunchCard, LLC's services are subject to limitations, delays, and other problems inherent in the use of the internet and electronic communications. PunchCard, LLCis not responsible for any delays, delivery failures, or other damage resulting from such problems.
                                </P>
                                <p>
                                    If downtime exceeds eight (8) units of downtime in any calendar month, PunchCard, LLCwill, upon your written request, credit your account (a "downtime credit") in an amount equal to the pro-rata price for one (1) day of service, for each 4 units of downtime in excess of eight (8) units in any calendar month.
                                </p>
                                <p>
                                    To receive downtime credit, you must request such credit by contacting PunchCard, LLCwithin seven (7) days after the occurrence of downtime. The aggregate maximum number of downtime credits to be issued for any and all instances of downtime occurring in a single calendar month will not exceed seven (7). Downtime credits will be applied upon issue of the first invoice following the request for downtime credit, unless the downtime occurs in your final month of service. In suchcase, a refund for the dollar value of the downtime credit will be mailed to you within thirty (30) days of the expiration of your service agreement.Contacting PunchCard, LLC
                                </p>
                                <p>
                                    If you have any questions with respect to our policies, please contact us at:
                                </p>
                                <p>
                                    Info@PunchCardLLC.com
                                    <br/>Or you may write at any time to:<br/>PunchCard,LLC1680FruitvilleRd#304<br/>Sarasota,FL34236
                                </p>
                                <p>
                                    <b>
                                        Ownership of Intellectual Property
                                    </b>
                                </p>
                                <P>
                                    Title to any and all proprietary rights in the Service components including, without limitation, the Software, PunchCard, LLC's web site and user interface will remain in and be the exclusive property of PunchCard, LLC
                                </P>
                                <p>
                                    Client will be the owner of all data or information created by Client and stored on PunchCard, LLC's application servers (collectively, "Client Data").
                                </p>
                                <p>
                                    Client hereby grants to PunchCard, LLCa non-exclusive, fully paid, world-wide and irrevocable license permitting PunchCard, LLCto copy, anonymize, aggregate, process and display Client Data to derive anonymous statistical and usage data, and data about the functionality of the Service, provided such data cannot be used to identify Client or its individual users ("Anonymous Data"), for the purposes of combining or incorporating such Anonymous Data with or into other similar data and information available, derived or obtained from other clients, licensees, users, or otherwise (when so combined or incorporated, referred to as "Aggregate Data"), so as to permit PunchCard, LLCto provide services including the copying, publication, distribution, display, licensing or sale of Aggregate Data and related or similar other statistics or data to third parties (and to Client should Client elect to subscribe for same) pursuant to a separate licensing or services arrangement or agreement. PunchCard, LLCwill be the owner of all right, title and interest in and to Aggregate Data.
                                </p>
                                <p>
                                    Any access by Client to Aggregate Data shall be pursuant to an additional license or services agreement.PunchCard, LLCmakes no representation, warranty, or guaranty as to the reliability, timeliness, quality, suitability, truth, availability, accuracy or completeness of the service or any component. PunchCard, LLCdoes not represent or warrant that (a) the use of the service will be secure, timely, uninterrupted or error-free or operate in combination with any other hardware, service, system or data, (b) the service will meet your requirements or expectations, (c) any stored data will be accurate or reliable, (d) the quality of any information obtained by you through the service will meet your requirements or expectations, (e) errors or defects will be corrected, or (f) the service or the communication facilities, including, without limitation, the internet that make the service available are free of viruses or other harmful components or are secure from interruption, interception or corruption by third parties. Except as expressly set forth in this section 8, the service is provided to you strictly on an "as is" basis.<br/>Non-Assignment
                                </p>
                                <p>
                                    Neither party may assign, voluntarily, by operation of law, or otherwise, any rights or delegate any duties under this agreement (other than the right to receive payments) without the other party's prior written consent, which consent will not be unreasonably withheld, except that PunchCard, LLCmay assign this agreement, without consent, in connection with a sale of all or substantially all of PunchCard, LLC's business or assets. This agreement will inure to the benefit of, and be binding upon the parties hereto, together with their respective legal representatives, successors, and assigns, as permitted herein.
                                </p>
                                <p>
                                    <b>
                                        Applicable Law
                                    </b>
                                </p>
                                <p>
                                    This agreement shall be subject to, construed by and enforced in accordance with the applicable state and federal laws without regard for its conflict of law principles and the parties agree to at torn to the exclusive jurisdiction of the court.
                                </p>
                                <p>
                                    <b>
                                        Dispute Resolution 
                                    </b>
                                </p>
                                <P>
                                    Except for any dispute concerning breach of confidentiality or infringement of any intellectual property right, which dispute will be subject to the exclusive jurisdiction of the courts of United States and the proper appeal courts from such courts, any dispute arising under this agreement will be subject tobinding arbitration by a single arbitrator with the American Arbitration Association ("AAA") in accordance with its relevant industry rules, if any. <br/>Software Upgrades 
                                </P>
                                <p>
                                    From time to time PunchCard, LLCwill release new versions of the software and will automatically upgrade the software to the latest version, upon seven (7) days notice to you, on the service administrator login screen.
                                </p>
                                <p>
                                    <b>
                                        Technical Support 
                                    </b>
                                </p>
                                <p>
                                    A member of PunchCard, LLC's technical support help desk staff will be available to assist you with problems and questions regarding the service. PunchCard, LLCwill supply telephone and/or email support to you regarding the service twenty four (24) hours a day, seven (7) days a week.You may contact PunchCard, LLC's technical support help desk via email at <span style="color: blue;">support@PunchCardLLC.com</span>, or by telephone at <span style="color: blue;">1-941-702-6070</span>. PunchCard, LLCmay, from time to time, develop additional methods for you to contact the help desk, and will make information regarding such methods available at PunchCard, LLC's website.
                                </p>
                            </div>
                        </div>
                        @endif

                        <div class="form-group">
                            <div class="col-md-6">
                                <hr />
                            </div>
                        </div>

                        <div class="form-group{{ $errors->has('approved_tos') ? ' has-error' : '' }}">

                            @if ($email)

                            <div class="col-md-6">
                                I agree to the Terms of Service:
                                <input type="checkbox" name="approved_tos" id="approved_tos" />

                                @if ($errors->has('approved_tos'))
                                    <span class="help-block">
                                        <strong>{{ $errors->first('approved_tos') }}</strong>
                                    </span>
                                @endif
                            </div>

                            

                            <div class="col-md-6">
                                <button type="submit" class="btn btn-primary" disabled id="submit_tos">
                                    Reset Password
                                </button>
                            </div>

                            @else

                            <input type="hidden" name="approved_tos" value="some" />

                            <div class="col-md-6">
                                <button type="submit" class="btn btn-primary" align="right">
                                    Reset Password
                                </button>
                            </div>

                            @endif
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
@endsection
@section('script')

$(document).ready(function () {
    $('#approved_tos').on('change', function() {
        if($(this).is(":checked")) {
            $('#submit_tos').prop('disabled', false);
        } else {
            $('#submit_tos').prop('disabled', true);
        }
    });
});
@endsection
