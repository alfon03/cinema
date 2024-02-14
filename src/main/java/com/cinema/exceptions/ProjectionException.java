package com.cinema.exceptions;

public class ProjectionException extends Exception {

	public ProjectionException() {
	}

	public ProjectionException(String message) {
		super(message);
	}

	public ProjectionException(Throwable cause) {
		super(cause);
	}

	public ProjectionException(String message, Throwable cause) {
		super(message, cause);
	}

	public ProjectionException(String message, Throwable cause, boolean enableSuppression, boolean writableStackTrace) {
		super(message, cause, enableSuppression, writableStackTrace);
	}

}
