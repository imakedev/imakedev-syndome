// Decompiled by DJ v3.12.12.96 Copyright 2011 Atanas Neshkov  Date: 5/27/2012 12:13:44 AM
// Home Page: http://members.fortunecity.com/neshkov/dj.html  http://www.neshkov.com/dj.html - Check often for new version!
// Decompiler options: packimports(3) 
// Source File Name:   SurveyForm.java

package th.co.imake.syndome.bpm.backoffice.form;

import java.io.Serializable;

public class SurveyForm implements Serializable {
    private static final long serialVersionUID = 1L;
	public Long maId;
	public Long msId;
	public String[] survey_name;
	public String[] survey_email;
	public int amountSend;
	public SurveyForm() {
	}

	public Long getMaId() {
		return maId;
	}

	public Long getMsId() {
		return msId;
	}

	public void setMsId(Long msId) {
		this.msId = msId;
	}

	public void setMaId(Long maId) {
		this.maId = maId;
	}

	public int getAmountSend() {
		return amountSend;
	}

	public void setAmountSend(int amountSend) {
		this.amountSend = amountSend;
	}

	public String[] getSurvey_name() {
		return survey_name;
	}

	public void setSurvey_name(String[] survey_name) {
		this.survey_name = survey_name;
	}

	public String[] getSurvey_email() {
		return survey_email;
	}

	public void setSurvey_email(String[] survey_email) {
		this.survey_email = survey_email;
	}
	
}
