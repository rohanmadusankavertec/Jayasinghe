/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.hibe.model;

import java.io.Serializable;
import java.util.Collection;
import java.util.Date;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author vertec-r
 */
@Entity
@Table(name = "invoice_info")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "InvoiceInfo.findAll", query = "SELECT i FROM InvoiceInfo i"),
    @NamedQuery(name = "InvoiceInfo.findById", query = "SELECT i FROM InvoiceInfo i WHERE i.id = :id"),
    @NamedQuery(name = "InvoiceInfo.findByDate", query = "SELECT i FROM InvoiceInfo i WHERE i.date = :date"),
    @NamedQuery(name = "InvoiceInfo.findByVehicleNo", query = "SELECT i FROM InvoiceInfo i WHERE i.vehicleNo = :vehicleNo"),
    @NamedQuery(name = "InvoiceInfo.findByVHeight", query = "SELECT i FROM InvoiceInfo i WHERE i.vHeight = :vHeight"),
    @NamedQuery(name = "InvoiceInfo.findByVWidth", query = "SELECT i FROM InvoiceInfo i WHERE i.vWidth = :vWidth"),
    @NamedQuery(name = "InvoiceInfo.findByVLong", query = "SELECT i FROM InvoiceInfo i WHERE i.vLong = :vLong"),
    @NamedQuery(name = "InvoiceInfo.findByIntime", query = "SELECT i FROM InvoiceInfo i WHERE i.intime = :intime"),
    @NamedQuery(name = "InvoiceInfo.findByLoadtime", query = "SELECT i FROM InvoiceInfo i WHERE i.loadtime = :loadtime"),
    @NamedQuery(name = "InvoiceInfo.findByIsValid", query = "SELECT i FROM InvoiceInfo i WHERE i.isValid = :isValid"),
    @NamedQuery(name = "InvoiceInfo.findByTotal", query = "SELECT i FROM InvoiceInfo i WHERE i.total = :total"),
    @NamedQuery(name = "InvoiceInfo.findByOutstanding", query = "SELECT i FROM InvoiceInfo i WHERE i.outstanding = :outstanding"),
    @NamedQuery(name = "InvoiceInfo.findByReceiver", query = "SELECT i FROM InvoiceInfo i WHERE i.receiver = :receiver")})
public class InvoiceInfo implements Serializable {

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "date")
    @Temporal(TemporalType.DATE)
    private Date date;
    @Column(name = "vehicle_no")
    private String vehicleNo;
    // @Max(value=?)  @Min(value=?)//if you know range of your decimal fields consider using these annotations to enforce field validation
    @Column(name = "v_height")
    private Double vHeight;
    @Column(name = "v_width")
    private Double vWidth;
    @Column(name = "v_long")
    private Double vLong;
    @Column(name = "intime")
    @Temporal(TemporalType.TIME)
    private Date intime;
    @Column(name = "loadtime")
    @Temporal(TemporalType.TIME)
    private Date loadtime;
    @Column(name = "is_valid")
    private Boolean isValid;
    @Column(name = "total")
    private Double total;
    @Column(name = "outstanding")
    private Double outstanding;
    @Column(name = "receiver")
    private String receiver;
    @JoinColumn(name = "customer_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Customer customerId;
    @JoinColumn(name = "security_officer_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private SecurityOfficer securityOfficerId;
    @JoinColumn(name = "supervisor_id", referencedColumnName = "id")
    @ManyToOne(optional = false)
    private Supervisor supervisorId;
    @JoinColumn(name = "added_by", referencedColumnName = "sysuser_id")
    @ManyToOne(optional = false)
    private SysUser addedBy;
    @OneToMany(cascade = CascadeType.ALL, mappedBy = "invoiceInfoId")
    private Collection<Invoice> invoiceCollection;

    public InvoiceInfo() {
    }

    public InvoiceInfo(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
        this.date = date;
    }

    public String getVehicleNo() {
        return vehicleNo;
    }

    public void setVehicleNo(String vehicleNo) {
        this.vehicleNo = vehicleNo;
    }

    public Double getVHeight() {
        return vHeight;
    }

    public void setVHeight(Double vHeight) {
        this.vHeight = vHeight;
    }

    public Double getVWidth() {
        return vWidth;
    }

    public void setVWidth(Double vWidth) {
        this.vWidth = vWidth;
    }

    public Double getVLong() {
        return vLong;
    }

    public void setVLong(Double vLong) {
        this.vLong = vLong;
    }

    public Date getIntime() {
        return intime;
    }

    public void setIntime(Date intime) {
        this.intime = intime;
    }

    public Date getLoadtime() {
        return loadtime;
    }

    public void setLoadtime(Date loadtime) {
        this.loadtime = loadtime;
    }

    public Boolean getIsValid() {
        return isValid;
    }

    public void setIsValid(Boolean isValid) {
        this.isValid = isValid;
    }

    public Double getTotal() {
        return total;
    }

    public void setTotal(Double total) {
        this.total = total;
    }

    public Double getOutstanding() {
        return outstanding;
    }

    public void setOutstanding(Double outstanding) {
        this.outstanding = outstanding;
    }

    public String getReceiver() {
        return receiver;
    }

    public void setReceiver(String receiver) {
        this.receiver = receiver;
    }

    public Customer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Customer customerId) {
        this.customerId = customerId;
    }

    public SecurityOfficer getSecurityOfficerId() {
        return securityOfficerId;
    }

    public void setSecurityOfficerId(SecurityOfficer securityOfficerId) {
        this.securityOfficerId = securityOfficerId;
    }

    public Supervisor getSupervisorId() {
        return supervisorId;
    }

    public void setSupervisorId(Supervisor supervisorId) {
        this.supervisorId = supervisorId;
    }

    public SysUser getAddedBy() {
        return addedBy;
    }

    public void setAddedBy(SysUser addedBy) {
        this.addedBy = addedBy;
    }

    @XmlTransient
    public Collection<Invoice> getInvoiceCollection() {
        return invoiceCollection;
    }

    public void setInvoiceCollection(Collection<Invoice> invoiceCollection) {
        this.invoiceCollection = invoiceCollection;
    }

    @Override
    public int hashCode() {
        int hash = 0;
        hash += (id != null ? id.hashCode() : 0);
        return hash;
    }

    @Override
    public boolean equals(Object object) {
        // TODO: Warning - this method won't work in the case the id fields are not set
        if (!(object instanceof InvoiceInfo)) {
            return false;
        }
        InvoiceInfo other = (InvoiceInfo) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vertec.hibe.model.InvoiceInfo[ id=" + id + " ]";
    }
    
}
