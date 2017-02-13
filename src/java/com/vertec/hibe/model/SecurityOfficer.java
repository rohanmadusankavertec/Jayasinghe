/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.vertec.hibe.model;

import java.io.Serializable;
import java.util.Collection;
import javax.persistence.Basic;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.NamedQueries;
import javax.persistence.NamedQuery;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlTransient;

/**
 *
 * @author vertec-r
 */
@Entity
@Table(name = "security_officer")
@XmlRootElement
@NamedQueries({
    @NamedQuery(name = "SecurityOfficer.findAll", query = "SELECT s FROM SecurityOfficer s"),
    @NamedQuery(name = "SecurityOfficer.findById", query = "SELECT s FROM SecurityOfficer s WHERE s.id = :id"),
    @NamedQuery(name = "SecurityOfficer.findByName", query = "SELECT s FROM SecurityOfficer s WHERE s.name = :name"),
    @NamedQuery(name = "SecurityOfficer.findByIsValid", query = "SELECT s FROM SecurityOfficer s WHERE s.isValid = :isValid")})
public class SecurityOfficer implements Serializable {

    @OneToMany(cascade = CascadeType.ALL, mappedBy = "securityOfficerId")
    private Collection<InvoiceInfo> invoiceInfoCollection;

    private static final long serialVersionUID = 1L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Basic(optional = false)
    @Column(name = "id")
    private Integer id;
    @Column(name = "name")
    private String name;
    @Column(name = "is_valid")
    private Boolean isValid;

    public SecurityOfficer() {
    }

    public SecurityOfficer(Integer id) {
        this.id = id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Boolean getIsValid() {
        return isValid;
    }

    public void setIsValid(Boolean isValid) {
        this.isValid = isValid;
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
        if (!(object instanceof SecurityOfficer)) {
            return false;
        }
        SecurityOfficer other = (SecurityOfficer) object;
        if ((this.id == null && other.id != null) || (this.id != null && !this.id.equals(other.id))) {
            return false;
        }
        return true;
    }

    @Override
    public String toString() {
        return "com.vertec.hibe.model.SecurityOfficer[ id=" + id + " ]";
    }

    @XmlTransient
    public Collection<InvoiceInfo> getInvoiceInfoCollection() {
        return invoiceInfoCollection;
    }

    public void setInvoiceInfoCollection(Collection<InvoiceInfo> invoiceInfoCollection) {
        this.invoiceInfoCollection = invoiceInfoCollection;
    }
    
}
