package vn.web.courseShop.domain;

import java.util.List;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "flags")
public class Flag {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

    @OneToMany(mappedBy = "flag")
    private List<FlagReportBridge> flagReportBridges;

    @Column(length = 50)
    private String description;

    public List<FlagReportBridge> getFlagReportBridges() {
        return flagReportBridges;
    }

    public void setFlagReportBridges(List<FlagReportBridge> flagReportBridges) {
        this.flagReportBridges = flagReportBridges;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public long getId() {
        return id;
    }

    public void setId(long id) {
        this.id = id;
    }
    
}
