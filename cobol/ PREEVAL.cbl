       IDENTIFICATION DIVISION.
       PROGRAM-ID. PREEVAL.
      *****************************************************************
      * Aplicación: PRESTAMOS (App B)
      * Programa: Evaluación de Préstamos
      * Descripción: Evalúa si un cliente califica para préstamo
      *****************************************************************

       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.

       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * Copybook compartido - mismo que usa App A
       COPY CLIENTE.

       01  WS-PRESTAMO.
           05 PRE-NUMERO            PIC 9(12).
           05 PRE-MONTO-SOLICITADO  PIC S9(11)V99 COMP-3.
           05 PRE-PLAZO-MESES       PIC 9(03).
           05 PRE-CLIENTE-ID        PIC 9(10).
           05 PRE-ESTADO-EVAL       PIC X(01).
              88 PRE-APROBADO       VALUE 'A'.
              88 PRE-RECHAZADO      VALUE 'R'.
              88 PRE-EN-ANALISIS    VALUE 'P'.

       01  WS-EVALUACION.
           05 WS-CALIF-MINIMA       PIC 9(02) VALUE 70.
           05 WS-RESULTADO          PIC X(50).

       PROCEDURE DIVISION.

       MAIN-PROCESS.
           DISPLAY '*** EVALUACION DE PRESTAMO ***'

      * Simular datos del cliente (obtenidos de sistema)
           MOVE 1234567890 TO CLI-ID
           MOVE 'MARIA' TO CLI-NOMBRE
           MOVE 'GONZALEZ' TO CLI-APELLIDO
           MOVE 'DNI' TO CLI-TIPO-DOC
           MOVE '87654321' TO CLI-NUM-DOC
           SET CLI-ACTIVO TO TRUE
           MOVE 85 TO CLI-CALIFICACION

           DISPLAY 'Evaluando cliente: ' CLI-NOMBRE ' ' CLI-APELLIDO
           DISPLAY 'ID: ' CLI-ID

      * Datos del préstamo solicitado
           MOVE 987654321098 TO PRE-NUMERO
           MOVE 50000.00 TO PRE-MONTO-SOLICITADO
           MOVE 24 TO PRE-PLAZO-MESES
           MOVE CLI-ID TO PRE-CLIENTE-ID

           DISPLAY 'Monto solicitado: ' PRE-MONTO-SOLICITADO
           DISPLAY 'Plazo: ' PRE-PLAZO-MESES ' meses'

      * Evaluación basada en calificación del cliente
           IF CLI-ACTIVO AND
              CLI-CALIFICACION >= WS-CALIF-MINIMA
              SET PRE-APROBADO TO TRUE
              MOVE 'PRESTAMO APROBADO' TO WS-RESULTADO
           ELSE
              SET PRE-RECHAZADO TO TRUE
              MOVE 'PRESTAMO RECHAZADO' TO WS-RESULTADO
           END-IF

           DISPLAY 'Calificacion cliente: ' CLI-CALIFICACION
           DISPLAY 'Resultado: ' WS-RESULTADO

           STOP RUN.