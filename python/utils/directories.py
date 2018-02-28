import os as os

ROOT_DIR = os.path.abspath( os.path.join( os.path.dirname( __file__ ) , "../../" ) )
ORIGINAL_DATA_DIR = os.path.join( ROOT_DIR , "data" , "00_original" )
INTERIM_DATA_DIR = os.path.join( ROOT_DIR , "data" , "01_interim" )

LOG_DIR = os.path.join( ROOT_DIR , "logs" )


def original_path( file ):
    return os.path.join( ORIGINAL_DATA_DIR , file )


def interim_path( file ):
    return os.path.join( INTERIM_DATA_DIR , file )


def log_path( file ):
    return os.path.join( LOG_DIR , file )
