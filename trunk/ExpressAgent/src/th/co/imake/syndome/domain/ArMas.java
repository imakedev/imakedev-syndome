package th.co.imake.syndome.domain;

import java.io.Serializable;

public class ArMas implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	/**
	 * @param args
	 */
	private String cuscode;//CUSCOD;
	private String custyp;//	CUSTYP	;
	private String prenam;//PRENAM	;
	private String cusnam;//CUSNAM;
	private String addr01;//ADDR01;
	private String addr02;//ADDR02;
	private String addr03;//ADDR03;
	private String zipcod;//ZIPCOD;
	private String telnum;//TELNUM;
	private String contact;//CONTACT;
	private String cusnam2;//CUSNAM2;
	private String taxid;//TAXID;
	private String taxtyp;//TAXTYP;
	private String taxpat;//TAXRAT;
	private String taxgrp;//TAXGRP;
	private String taxcond;//TAXCOND;
	private String shipto;//SHIPTO;
	private String slmcod;//SLMCOD;
	private String areacod;//AREACOD;
	private String paytrm;//PAYTRM;
	private String paycond;//PAYCOND;
	private String payer;//PAYER;
	private String tabpr;//TABPR;
	private String disc;//DISC;
	private String balance;//BALANCE;
	private String 	chqrcv;//CHQRCV;
	private String crline;//CRLINE;
	private String lasivc;//LASIVC;
	private String accnum;//ACCNUM;
	private String remark;//REMARK;
	private String dlvby;//DLVBY;
	private String tracksal;//TRACKSAL;
	private String creby;//CREBY;
	private String 	credat;//CREDAT;
	private String userid;//USERID;
	private String chgdat;//CHGDAT;
	private String status;//STATUS;
	private String inactdat;//INACTDAT;
	
	private Object[] objectArrays;
	public String getCuscode() {
		return cuscode;
	}
	public void setCuscode(String cuscode) {
		this.cuscode = cuscode;
	}
	public String getCustyp() {
		return custyp;
	}
	public void setCustyp(String custyp) {
		this.custyp = custyp;
	}
	public String getPrenam() {
		return prenam;
	}
	public void setPrenam(String prenam) {
		this.prenam = prenam;
	}
	public String getCusnam() {
		return cusnam;
	}
	public void setCusnam(String cusnam) {
		this.cusnam = cusnam;
	}
	public String getAddr01() {
		return addr01;
	}
	public void setAddr01(String addr01) {
		this.addr01 = addr01;
	}
	public String getAddr02() {
		return addr02;
	}
	public void setAddr02(String addr02) {
		this.addr02 = addr02;
	}
	public String getAddr03() {
		return addr03;
	}
	public void setAddr03(String addr03) {
		this.addr03 = addr03;
	}
	public String getZipcod() {
		return zipcod;
	}
	public void setZipcod(String zipcod) {
		this.zipcod = zipcod;
	}
	public String getTelnum() {
		return telnum;
	}
	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	public String getCusnam2() {
		return cusnam2;
	}
	public void setCusnam2(String cusnam2) {
		this.cusnam2 = cusnam2;
	}
	public String getTaxid() {
		return taxid;
	}
	public void setTaxid(String taxid) {
		this.taxid = taxid;
	}
	public String getTaxtyp() {
		return taxtyp;
	}
	public void setTaxtyp(String taxtyp) {
		this.taxtyp = taxtyp;
	}
	public String getTaxpat() {
		return taxpat;
	}
	public void setTaxpat(String taxpat) {
		this.taxpat = taxpat;
	}
	public String getTaxgrp() {
		return taxgrp;
	}
	public void setTaxgrp(String taxgrp) {
		this.taxgrp = taxgrp;
	}
	public String getTaxcond() {
		return taxcond;
	}
	public void setTaxcond(String taxcond) {
		this.taxcond = taxcond;
	}
	public String getShipto() {
		return shipto;
	}
	public void setShipto(String shipto) {
		this.shipto = shipto;
	}
	public String getSlmcod() {
		return slmcod;
	}
	public void setSlmcod(String slmcod) {
		this.slmcod = slmcod;
	}
	public String getAreacod() {
		return areacod;
	}
	public void setAreacod(String areacod) {
		this.areacod = areacod;
	}
	public String getPaytrm() {
		return paytrm;
	}
	public void setPaytrm(String paytrm) {
		this.paytrm = paytrm;
	}
	public String getPaycond() {
		return paycond;
	}
	public void setPaycond(String paycond) {
		this.paycond = paycond;
	}
	public String getPayer() {
		return payer;
	}
	public void setPayer(String payer) {
		this.payer = payer;
	}
	public String getTabpr() {
		return tabpr;
	}
	public void setTabpr(String tabpr) {
		this.tabpr = tabpr;
	}
	public String getDisc() {
		return disc;
	}
	public void setDisc(String disc) {
		this.disc = disc;
	}
	public String getBalance() {
		return balance;
	}
	public void setBalance(String balance) {
		this.balance = balance;
	}
	public String getChqrcv() {
		return chqrcv;
	}
	public void setChqrcv(String chqrcv) {
		this.chqrcv = chqrcv;
	}
	public String getCrline() {
		return crline;
	}
	public void setCrline(String crline) {
		this.crline = crline;
	}
	public String getLasivc() {
		return lasivc;
	}
	public void setLasivc(String lasivc) {
		this.lasivc = lasivc;
	}
	public String getAccnum() {
		return accnum;
	}
	public void setAccnum(String accnum) {
		this.accnum = accnum;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getDlvby() {
		return dlvby;
	}
	public void setDlvby(String dlvby) {
		this.dlvby = dlvby;
	}
	public String getTracksal() {
		return tracksal;
	}
	public void setTracksal(String tracksal) {
		this.tracksal = tracksal;
	}
	public String getCreby() {
		return creby;
	}
	public void setCreby(String creby) {
		this.creby = creby;
	}
	public String getCredat() {
		return credat;
	}
	public void setCredat(String credat) {
		this.credat = credat;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getChgdat() {
		return chgdat;
	}
	public void setChgdat(String chgdat) {
		this.chgdat = chgdat;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getInactdat() {
		return inactdat;
	}
	public void setInactdat(String inactdat) {
		this.inactdat = inactdat;
	}
	public Object[] getObjectArrays() {
		return objectArrays;
	}
	public void setObjectArrays(Object[] objectArrays) {
		this.objectArrays = objectArrays;
	}

}
