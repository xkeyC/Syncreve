package db

import (
	"fmt"
	"github.com/google/uuid"
	"gorm.io/driver/sqlite"
	"gorm.io/gorm"
	"gorm.io/gorm/logger"
	"log"
	"os"
	"time"
)

var DB *gorm.DB

type BaseData struct {
	ID        uuid.UUID      `gorm:"type:uuid" json:"ID"`
	CreatedAt time.Time      `json:"createdAt,omitempty"`
	UpdatedAt time.Time      `json:"updatedAt,omitempty"`
	DeletedAt gorm.DeletedAt `gorm:"index" json:"deletedAt,omitempty"`
}

func (base *BaseData) BeforeCreate(tx *gorm.DB) error {
	u := uuid.New()
	tx.Statement.SetColumn("ID", u)
	return nil
}

func Init(workingDir string) error {
	/// for debug
	newLogger := logger.New(
		log.New(os.Stdout, "\r\n", log.LstdFlags), // io writer
		logger.Config{
			SlowThreshold:             time.Second, // Slow SQL threshold
			LogLevel:                  logger.Info, // Log level
			IgnoreRecordNotFoundError: false,       // Ignore ErrRecordNotFound error for logger
			ParameterizedQueries:      false,       // Don't include params in the SQL log
			Colorful:                  false,       // Disable color
		},
	)

	dbPath := workingDir + "/libsyncreve/db"
	dbFilPath := dbPath + "/database.db"
	fmt.Println("Sqlite Path ==", dbFilPath)
	err := os.MkdirAll(dbPath, os.ModePerm)
	if err != nil {
		return err
	}
	DB, err = gorm.Open(sqlite.Open(dbFilPath), &gorm.Config{
		Logger: newLogger,
	})
	if err != nil {
		return err
	}
	return _initTables()
}

func _initTables() error {
	return DB.AutoMigrate(&DownloadQueue{})
}
