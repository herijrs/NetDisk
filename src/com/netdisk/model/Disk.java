package com.netdisk.model;

import java.math.BigInteger;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.OneToOne;
import javax.persistence.Table;

@Entity
@Table(name="diskinfo")
public class Disk {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Integer id;
	
	private Integer disk_userid;
	private BigInteger total_size;
	private BigInteger used_size;
	
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Integer getDisk_userid() {
		return disk_userid;
	}
	public void setDisk_userid(Integer disk_userid) {
		this.disk_userid = disk_userid;
	}
	public BigInteger getTotal_size() {
		return total_size;
	}
	public void setTotal_size(BigInteger total_size) {
		this.total_size = total_size;
	}
	public BigInteger getUsed_size() {
		return used_size;
	}
	public void setUsed_size(BigInteger used_size) {
		this.used_size = used_size;
	}
	
	
}
