package th.co.imake.syndome.bpm.xstream;

import java.io.Serializable;

import th.co.imake.syndome.bpm.xstream.common.VServiceXML;

import com.thoughtworks.xstream.annotations.XStreamAlias;


/**
 * The persistent class for the BPM_ARMAS database table.
 * 
 */
@XStreamAlias("BpmArma")
public class BpmArma  extends VServiceXML implements Serializable {
	private static final long serialVersionUID = 1L;

	 
	private String cuscod;
 
	private String accnum;
 
	private String addr01;

	private String addr02;

	private String addr03;

	private String areacod;

	private String balance;

	private String chgdat;

	private String chqrcv;

	private String contact;

	private String creby;

	private String credat;

	private String crline;

	private String cusnam;

	private String cusnam2;

	private String custyp;

	private String disc;

	private String dlvby;

	private String inactdat;

	private String lasivc;

	private String paycond;

	private String payer;

	private String paytrm;

	private String prenam;

	private String remark;

	private String shipto;

	private String slmcod;

	private String status;

	private String synDatetime;

	private String tabpr;

	private String taxcond;

	private String taxgrp;

	private String taxid;

	private String taxrat;

	private String taxtyp;

	private String telnum;

	private String tracksal;

	private String userid;

	private String zipcod;

	public BpmArma() {
	}

	public String getCuscod() {
		return this.cuscod;
	}

	public void setCuscod(String cuscod) {
		this.cuscod = cuscod;
	}

	public String getAccnum() {
		return this.accnum;
	}

	public void setAccnum(String accnum) {
		this.accnum = accnum;
	}

	public String getAddr01() {
		return this.addr01;
	}

	public void setAddr01(String addr01) {
		this.addr01 = addr01;
	}

	public String getAddr02() {
		return this.addr02;
	}

	public void setAddr02(String addr02) {
		this.addr02 = addr02;
	}

	public String getAddr03() {
		return this.addr03;
	}

	public void setAddr03(String addr03) {
		this.addr03 = addr03;
	}

	public String getAreacod() {
		return this.areacod;
	}

	public void setAreacod(String areacod) {
		this.areacod = areacod;
	}

	public String getBalance() {
		return this.balance;
	}

	public void setBalance(String balance) {
		this.balance = balance;
	}

	public String getChgdat() {
		return this.chgdat;
	}

	public void setChgdat(String chgdat) {
		this.chgdat = chgdat;
	}

	public String getChqrcv() {
		return this.chqrcv;
	}

	public void setChqrcv(String chqrcv) {
		this.chqrcv = chqrcv;
	}

	public String getContact() {
		return this.contact;
	}

	public void setContact(String contact) {
		this.contact = contact;
	}

	public String getCreby() {
		return this.creby;
	}

	public void setCreby(String creby) {
		this.creby = creby;
	}

	public String getCredat() {
		return this.credat;
	}

	public void setCredat(String credat) {
		this.credat = credat;
	}

	public String getCrline() {
		return this.crline;
	}

	public void setCrline(String crline) {
		this.crline = crline;
	}

	public String getCusnam() {
		return this.cusnam;
	}

	public void setCusnam(String cusnam) {
		this.cusnam = cusnam;
	}

	public String getCusnam2() {
		return this.cusnam2;
	}

	public void setCusnam2(String cusnam2) {
		this.cusnam2 = cusnam2;
	}

	public String getCustyp() {
		return this.custyp;
	}

	public void setCustyp(String custyp) {
		this.custyp = custyp;
	}

	public String getDisc() {
		return this.disc;
	}

	public void setDisc(String disc) {
		this.disc = disc;
	}

	public String getDlvby() {
		return this.dlvby;
	}

	public void setDlvby(String dlvby) {
		this.dlvby = dlvby;
	}

	public String getInactdat() {
		return this.inactdat;
	}

	public void setInactdat(String inactdat) {
		this.inactdat = inactdat;
	}

	public String getLasivc() {
		return this.lasivc;
	}

	public void setLasivc(String lasivc) {
		this.lasivc = lasivc;
	}

	public String getPaycond() {
		return this.paycond;
	}

	public void setPaycond(String paycond) {
		this.paycond = paycond;
	}

	public String getPayer() {
		return this.payer;
	}

	public void setPayer(String payer) {
		this.payer = payer;
	}

	public String getPaytrm() {
		return this.paytrm;
	}

	public void setPaytrm(String paytrm) {
		this.paytrm = paytrm;
	}

	public String getPrenam() {
		return this.prenam;
	}

	public void setPrenam(String prenam) {
		this.prenam = prenam;
	}

	public String getRemark() {
		return this.remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getShipto() {
		return this.shipto;
	}

	public void setShipto(String shipto) {
		this.shipto = shipto;
	}

	public String getSlmcod() {
		return this.slmcod;
	}

	public void setSlmcod(String slmcod) {
		this.slmcod = slmcod;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getSynDatetime() {
		return this.synDatetime;
	}

	public void setSynDatetime(String synDatetime) {
		this.synDatetime = synDatetime;
	}

	public String getTabpr() {
		return this.tabpr;
	}

	public void setTabpr(String tabpr) {
		this.tabpr = tabpr;
	}

	public String getTaxcond() {
		return this.taxcond;
	}

	public void setTaxcond(String taxcond) {
		this.taxcond = taxcond;
	}

	public String getTaxgrp() {
		return this.taxgrp;
	}

	public void setTaxgrp(String taxgrp) {
		this.taxgrp = taxgrp;
	}

	public String getTaxid() {
		return this.taxid;
	}

	public void setTaxid(String taxid) {
		this.taxid = taxid;
	}

	public String getTaxrat() {
		return this.taxrat;
	}

	public void setTaxrat(String taxrat) {
		this.taxrat = taxrat;
	}

	public String getTaxtyp() {
		return this.taxtyp;
	}

	public void setTaxtyp(String taxtyp) {
		this.taxtyp = taxtyp;
	}

	public String getTelnum() {
		return this.telnum;
	}

	public void setTelnum(String telnum) {
		this.telnum = telnum;
	}

	public String getTracksal() {
		return this.tracksal;
	}

	public void setTracksal(String tracksal) {
		this.tracksal = tracksal;
	}

	public String getUserid() {
		return this.userid;
	}

	public void setUserid(String userid) {
		this.userid = userid;
	}

	public String getZipcod() {
		return this.zipcod;
	}

	public void setZipcod(String zipcod) {
		this.zipcod = zipcod;
	}

}