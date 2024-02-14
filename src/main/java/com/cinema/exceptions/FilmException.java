package com.cinema.exceptions;

public class FilmException extends Exception {

	public FilmException() {
	}

	public FilmException(String message) {
		super(message);
	}

	public FilmException(Throwable cause) {
		super(cause);
	}

	public FilmException(String message, Throwable cause) {
		super(message, cause);
	}

	public FilmException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
